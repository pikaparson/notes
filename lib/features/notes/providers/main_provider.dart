import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_list/features/notes/providers/note_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/data/classes/list_item_class.dart';
import '../../../core/data/classes/note_class.dart';
import '../../../core/hive/hive_keys.dart';

part 'main_provider.g.dart';

@riverpod
/// Провайдер основной страницы
class MainNotifier extends _$MainNotifier {
  @override
  MainState build() {
    ref.keepAlive();
    DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day
    );
    return MainState(
        currentDate: today,
        currentWeek: _getWeekByCurrentDate(today),
        today: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day
        ),
        notes: []
    );
  }

  /// Открытие хранилищ
  static Future<Box<NoteClass>> _openBoxIfNeeded(String key) async {
    if (!Hive.isBoxOpen(key)) {
      return await Hive.openBox<NoteClass>(key);
    }
    return Hive.box<NoteClass>(key);
  }

  /// Загрузка сегодняшнего дня
  Future<void> loadToday() async {
    if(!ref.mounted) return;

    state = state.copyWith(
      currentDate: DateTime.now(),
      currentWeek: _getWeekByCurrentDate(DateTime.now()),
      notes: await getNotesByToday()
    );
  }

  /// Обновление данных после выбора даты недели
  Future<void> updateDataAfterTapOnWeek(DateTime newDate) async {
    state = state.copyWith(
        currentDate: newDate,
        notes: await getNotesByCurrentDate(newDate)
    );
  }

  /// Обновление данных после выбора даты через календарь
  Future<void> updateDataAfterTapOnCalendar(DateTime newDate) async {
    state = state.copyWith(
      currentDate: newDate,
      currentWeek: _getWeekByCurrentDate(newDate),
      notes: await getNotesByCurrentDate(newDate)
    );
  }

  /// Обновление данных после свайпа недели вправо
  Future<void> updateDataAfterRightSwipe(DateTime date) async {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    final newMonday = monday.add(Duration(days: 7));
    state = state.copyWith(
        currentDate: newMonday,
        currentWeek: _getWeekByCurrentDate(newMonday),
        notes: await getNotesByCurrentDate(newMonday)
    );
  }

  /// Обновление данных после свайпа недели вправо
  Future<void> updateDataAfterLeftSwipe(DateTime date) async {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    final newMonday = monday.subtract(Duration(days: 7));
    state = state.copyWith(
        currentDate: newMonday,
        currentWeek: _getWeekByCurrentDate(newMonday),
        notes: await getNotesByCurrentDate(newMonday)
    );
  }

  /// Получение hive-ключа сегодняшнего дня
  static String _getHiveKeyByToday() {
    return '${HiveKeys.notes}_'
        '${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}';
  }

  /// Получение hive-ключа по выбранной дате
  static String _getHiveKeyByCurrentDate(DateTime currentDate) {
    return '${HiveKeys.notes}_'
        '${currentDate.year}${currentDate.month}${currentDate.day}';
  }

  /// Получение заметок сегодняшнего дня
  static Future<List<NoteClass>> getNotesByToday() async {
    final key = _getHiveKeyByToday();
    Box<NoteClass> box = await _openBoxIfNeeded(key);
    List<NoteClass> notes = box.values.toList();
    return notes;
  }

  /// Получение заметок выбранного дня
  static Future<List<NoteClass>> getNotesByCurrentDate(DateTime currentDate) async {
    final key = _getHiveKeyByCurrentDate(currentDate);
    Box<NoteClass> box = await _openBoxIfNeeded(key);
    List<NoteClass> notes = box.values.toList();
    return notes;
  }

  /// Добавление заметки в хранилище и обновление состояния выбранного дня
  Future<void> addNote(NoteClass note, DateTime currentDate) async {
    final key = _getHiveKeyByCurrentDate(currentDate);
    Box<NoteClass> box = await _openBoxIfNeeded(key);
    box.add(note);
    state = state.copyWith(
        notes: box.values.toList()
    );
  }

  /// Неделя по выбранной дате
  List<DateTime> _getWeekByCurrentDate(DateTime currentDate) {
    final monday = currentDate.subtract(Duration(days: currentDate.weekday - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  /// Удаление заметки из хранилища и обновление состояния
  Future<void> deleteNote(NoteClass note) async {
    final key = _getHiveKeyByCurrentDate(note.date);
    final box = await _openBoxIfNeeded(key);

    final keysToDelete = <dynamic>[];
    for (final k in box.keys) {
      final existing = box.get(k);
      if (existing != null && _notesEqual(existing, note)) {
        keysToDelete.add(k);
      }
    }

    for (final k in keysToDelete) {
      await box.delete(k);
    }

    WidgetsBinding.instance.addPostFrameCallback( (_) async {
      state = state.copyWith(
        notes: await getNotesByCurrentDate(state.currentDate),
      );
    });
  }

  /// Сравнение двух заметок по всем полям
  bool _notesEqual(NoteClass a, NoteClass b) {
    return a.name == b.name &&
        a.description == b.description &&
        a.date == b.date &&
        a.color == b.color &&
        a.type == b.type &&
        a.time == b.time &&
        _listItemsEqual(a.listItems, b.listItems);
  }

  /// Сравнение списков ListItemClass
  bool _listItemsEqual(List<ListItemClass>? a, List<ListItemClass>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].name != b[i].name || a[i].isChecked != b[i].isChecked) {
        return false;
      }
    }
    return true;
  }

  /// Переход на страницу с формой для заполнения для создания заметки
  void openFormScreenToAddNote(BuildContext context, DateTime currentDate) {
    Navigator.of(context).pushNamed(
        "/noteFormScreen",
        arguments: {
          'date': currentDate,
        }
    ).then((result) {
      WidgetsBinding.instance.addPostFrameCallback( (_) async {
        state = state.copyWith(
          notes: await getNotesByCurrentDate(state.currentDate),
        );
      });
    }
    );
  }

  /// Переход на страницу с формой для заполнения для редактирования заметки
  /// ToDo: добавить передачу заметки
  void openFormScreenToUpdateNote(BuildContext context, NoteClass? note) {
    Navigator.of(context).pushNamed(
      '/noteFormScreen',
      arguments: {
        'note': note,
      }
    ).then((result) {
      WidgetsBinding.instance.addPostFrameCallback( (_) {
        /// ToDo: добавить обновление заметки в Hive и в состоянии
      });
    }
    );
  }
}