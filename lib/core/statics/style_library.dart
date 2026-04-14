import 'package:flutter/cupertino.dart';
import 'color_library.dart';

/// Библиотека стилей текста
class StyleLibrary {

  /// Основной текст / Заполнение карточки
  static const main = TextStyle(
    fontFamily: 'Roboto',
    color: ColorLibrary.text,
    fontSize: 20,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
    height: 24 / 20
  );

  /// Название карточки
  static final cardTitle = main.copyWith(
    fontWeight: FontWeight.bold,
  );

  /// Кнопка "Перейти на сегодняшний день"
  static final goToToday = main.copyWith(
    color: ColorLibrary.white,
  );

  /// Название страницы
  static final title = main.copyWith(
    color: ColorLibrary.mainGray,
    fontSize: 32,
    height: 39 / 32
  );

  /// Дата
  static final date = main.copyWith(
    color: ColorLibrary.mainGray,
    fontSize: 24,
    height: 29 / 24
  );

  /// Название дня недели
  static final nameOfDayOfWeek = main.copyWith(
      color: ColorLibrary.white,
      fontSize: 28,
      height: 34 / 28
  );

  /// День месяца
  static final day = main.copyWith(
      color: ColorLibrary.white,
      fontSize: 28,
      height: 34 / 28
  );

  /// Название диалогового окна
  static final dialogName = main.copyWith(
      fontSize: 24,
      height: 28 / 24
  );

  /// Заполнение диалогового окна
  static final dialogContent = main.copyWith(
      fontSize: 15,
      height: 18 / 15
  );

  /// 1. Кнопка диалогового окна
  /// 2. Название блока диалогового окна
  static final dialogButton = main.copyWith(
      fontSize: 20,
      height: 23 / 20
  );
}