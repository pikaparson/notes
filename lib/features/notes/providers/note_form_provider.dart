import 'package:flutter/material.dart';
import 'package:notes_list/core/data/classes/note_class.dart';
import 'package:notes_list/core/data/enums/note_types.dart';
import 'package:notes_list/features/notes/providers/note_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/data/classes/list_item_class.dart';
import '../../../core/data/enums/colors.dart';
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

  /// Получение название цвета для экрана
  String getDisplayName(CardColors color) {
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

  /// Получение цвета
  Color getColor(CardColors color) {
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