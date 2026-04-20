import 'dart:core';
import 'package:flutter/cupertino.dart';

import '../../../core/data/classes/note_class.dart';

/// Состояния главного экрана
class MainState {
  /// Конструктор состояния главного экрана
  MainState({
    required this.currentDate,
    required this.currentWeek,
    required this.notes,
    DateTime? today,
    UniqueKey? slidableKey,
  }) : today = today ?? DateTime.now(),
        slidableKey = slidableKey ?? UniqueKey();

  /// Выбранный день недели
  DateTime currentDate;

  /// Выбранная неделя
  List<DateTime> currentWeek;

  /// Сегодня
  DateTime today;

  /// Заметки выбранного дня
  List<NoteClass> notes;

  /// Ключ для обновления списка из элементов с возможностью свайпа
  final UniqueKey slidableKey;

  /// Возвращение копии с измененным состоянием
  MainState copyWith({
    DateTime? currentDate,
    List<DateTime>? currentWeek,
    List<NoteClass>? notes
  }) {
    return MainState(
        currentDate: currentDate ?? this.currentDate,
        currentWeek: currentWeek ?? this.currentWeek,
        notes: notes ?? this.notes
    );
  }
}

/// Состояние страницы с формой заполнения заметки
class NoteFormState {
  /// Конструктор состояния страницы с формой заполнения заметки
  NoteFormState({
    required this.note
  });

  /// Заметка
  /// Если note = null, пользователь создает заметку
  /// Если note != null, пользователь редактирует заметку
  NoteClass? note;

  /// Возвращение копии с измененным состоянием
  NoteFormState copyWith({
    NoteClass? note
  }) {
    return NoteFormState(
        note: note ?? this.note
    );
  }
}