import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_list/core/data/classes/note_class.dart';
import 'package:notes_list/core/data/enums/note_types.dart';
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