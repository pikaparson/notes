import 'package:notes_list/core/data/classes/note_class.dart';
import 'package:notes_list/core/data/enums/note_types.dart';
import 'package:notes_list/features/notes/providers/note_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/data/classes/list_item_class.dart';
import '../../../core/data/enums/colors.dart';

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

  /// Загрузка заметки
  void loadNote(NoteClass? note) {
    state.copyWith(
        note: note
    );
  }

  /// Форматирование даты
  String toFormatDate(DateTime day) {
    return '${day.day >= 10 ? day.day : '0${day.day}'}.'
        '${day.month >= 10 ? day.month : '0${day.month}'}.'
        '${day.year >= 10 ? day.year : '0${day.year}'}';
  }

  /// Создание заметки и возвращение на главный экран
  /// ToDo: Дописать
  void addNoteAndCloseScreen({
    required String name,
    String? description,
    required DateTime date,
    required CardColors color,
    required NoteTypes type,
    DateTime? time,
    List<ListItemClass>? listItems,
    required DateTime createDate
  }) {
    NoteClass newNote = NoteClass(
        name: name,
        description: description,
        date: date,
        color: color,
        type: type,
        time: time,
        listItems: listItems
    );
  }

  /// Обновление заметки и возвращение на главный экран
  /// ToDo: Дописать
  void updateNoteAndCloseScreen({
    required NoteClass note,
    required String name,
    String? description,
    required DateTime date,
    required CardColors color,
    required NoteTypes type,
    DateTime? time,
    List<ListItemClass>? listItems,
  }) {
    NoteClass updateNote = note.copyWith(
      name: name,
      description: description,
      date: date,
      color: color,
      type: type,
      time: time,
      listItems: listItems,
    );
  }
}