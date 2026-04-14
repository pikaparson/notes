import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';

import '../../../../../core/statics/color_library.dart';

/// Кнопка "Сохранить"
/// ToDo: передает функцию
Widget saveButton() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
          color: ColorLibrary.mainGray,
          borderRadius: BorderRadius.circular(12)
      ),
      width: 372,
      height: 50,
      child: Center(
        child: Text(
          'Сохранить',
          style: StyleLibrary.goToToday,
        ),
      ),
    ),
  );
}