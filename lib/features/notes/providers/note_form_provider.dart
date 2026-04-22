import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_list/core/data/classes/note_class.dart';
import 'package:notes_list/features/notes/providers/note_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/data/classes/list_item_class.dart';
import '../../../core/data/enums/colors.dart';
import '../../../core/hive/hive_keys.dart';
import '../../../core/statics/color_library.dart';

part 'note_form_provider.g.dart';

@riverpod
/// Провайдер страницы с формой заполнения заметки
class NoteFormNotifier extends _$NoteFormNotifier {
  @override
  NoteFormState build() {
    ref.keepAlive();
    return NoteFormState(
        note: null
    );
  }

  /// Сброс состояния
  void reset() {
    state = NoteFormState(note: null);
  }

  /// Загрузка заметки
  void loadNote(NoteClass? note) {
    state = state.copyWith(
        note: note
    );
  }

  /// Форматирование даты в строку
  String dateToString(DateTime date) {
    return '${date.day >= 10 ? date.day : '0${date.day}'}.'
        '${date.month >= 10 ? date.month : '0${date.month}'}.'
        '${date.year >= 10 ? date.year : '0${date.year}'}';
  }

  /// Форматирование даты в DateTime
  DateTime dateToDateTime(String date) {
    List<String> parts = date.split('.');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  /// Получение название цвета для экрана по перечислению
  String getDisplayNameByEnum(CardColors color) {
    switch (color) {
      case CardColors.Red:
        return 'Красный';
      case CardColors.Orange:
        return 'Оранжевый';
      case CardColors.Yellow:
        return 'Желтый';
      case CardColors.Green:
        return 'Зеленый';
      case CardColors.LightBlue:
        return 'Голубой';
      case CardColors.Blue:
        return 'Синий';
      case CardColors.Violet:
        return 'Фиолетовый';
      case CardColors.Pink:
        return 'Розовый';
      case CardColors.Brown:
        return 'Коричневый';
      default:
        return 'Неизвестно';
    }
  }

  /// Получение цвета по перечислению
  Color getColorByEnum(CardColors color) {
    switch (color) {
      case CardColors.Red:
        return  ColorLibrary.redCard;
      case CardColors.Orange:
        return  ColorLibrary.orangeCard;
      case CardColors.Yellow:
        return  ColorLibrary.yellowCard;
      case CardColors.Green:
        return  ColorLibrary.greenCard;
      case CardColors.LightBlue:
        return  ColorLibrary.lightBlueCard;
      case CardColors.Blue:
        return  ColorLibrary.blueCard;
      case CardColors.Violet:
        return  ColorLibrary.violetCard;
      case CardColors.Pink:
        return  ColorLibrary.pinkCard;
      case CardColors.Brown:
        return  ColorLibrary.brownCard;
      default:
        return ColorLibrary.redCard;
    }
  }

  /// Получение цвета по его названию
  Color getColorByName(String name) {
    switch (name) {
      case 'Красный':
        return ColorLibrary.redCard;
      case 'Оранжевый':
        return ColorLibrary.orangeCard;
      case 'Желтый':
        return ColorLibrary.yellowCard;
      case 'Зеленый':
        return ColorLibrary.greenCard;
      case 'Голубой':
        return ColorLibrary.lightBlueCard;
      case 'Синий':
        return ColorLibrary.blueCard;
      case 'Фиолетовый':
        return ColorLibrary.violetCard;
      case 'Розовый':
        return ColorLibrary.pinkCard;
      case 'Коричневый':
        return ColorLibrary.brownCard;
      default:
        return ColorLibrary.redCard;
    }
  }

  /// Получение перечисление цвета по его названию
  CardColors getColorEnumByName(String name) {
    switch (name) {
      case 'Красный':
        return CardColors.Red;
      case 'Оранжевый':
        return CardColors.Orange;
      case 'Желтый':
        return CardColors.Yellow;
      case 'Зеленый':
        return CardColors.Green;
      case 'Голубой':
        return CardColors.LightBlue;
      case 'Синий':
        return CardColors.Blue;
      case 'Фиолетовый':
        return CardColors.Violet;
      case 'Розовый':
        return CardColors.Pink;
      case 'Коричневый':
        return CardColors.Brown;
      default:
        return CardColors.Red;
    }
  }

  /// Получение выбранного цвета
  Color getCurrentColor(String text) {
    try {
      return getColorByName(text);
    } catch (e) {
      return ColorLibrary.redCard;
    }
  }

  /// Открытие хранилищ
  static Future<Box<NoteClass>> _openBoxIfNeeded(String key) async {
    if (!Hive.isBoxOpen(key)) {
      return await Hive.openBox<NoteClass>(key);
    }
    return Hive.box<NoteClass>(key);
  }

  /// Получение hive-ключа по выбранной дате
  static String _getHiveKeyByCurrentDate(DateTime currentDate) {
    return '${HiveKeys.notes}_'
        '${currentDate.year}${currentDate.month}${currentDate.day}';
  }

  /// Создание заметки и возвращение на главный экран
  Future<void> addNoteAndCloseScreen(BuildContext context, NoteClass newNote) async {
    final key = _getHiveKeyByCurrentDate(newNote.date);
    Box<NoteClass> box = await _openBoxIfNeeded(key);
    box.add(newNote);
    Navigator.of(context).pop();
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

  /// Обновление заметки в хранилище (с учётом возможного изменения даты)
  Future<void> updateNote(NoteClass oldNote, NoteClass updatedNote) async {

    if (oldNote.date.year == updatedNote.date.year &&
        oldNote.date.month == updatedNote.date.month &&
        oldNote.date.day == updatedNote.date.day) {
      final key = _getHiveKeyByCurrentDate(oldNote.date);
      final box = await _openBoxIfNeeded(key);

      dynamic keyToUpdate;
      for (final k in box.keys) {
        final existing = box.get(k);
        if (existing != null && _notesEqual(existing, oldNote)) {
          keyToUpdate = k;
          break;
        }
      }
      if (keyToUpdate != null) {
        await box.put(keyToUpdate, updatedNote);
      }
    } else {
      final oldKey = _getHiveKeyByCurrentDate(oldNote.date);
      final oldBox = await _openBoxIfNeeded(oldKey);
      dynamic keyToDelete;
      for (final k in oldBox.keys) {
        final existing = oldBox.get(k);
        if (existing != null && _notesEqual(existing, oldNote)) {
          keyToDelete = k;
          break;
        }
      }
      if (keyToDelete != null) {
        await oldBox.delete(keyToDelete);
      }

      final newKey = _getHiveKeyByCurrentDate(updatedNote.date);
      final newBox = await _openBoxIfNeeded(newKey);
      await newBox.add(updatedNote);
    }
  }

  /// Удаление заметки из хранилища и обновление состояния
  Future<void> deleteNote(BuildContext context, NoteClass note) async {
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

    Navigator.pop(context);
  }
}