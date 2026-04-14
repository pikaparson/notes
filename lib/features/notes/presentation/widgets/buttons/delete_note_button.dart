import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';

import '../../../../../core/statics/color_library.dart';

/// Кнопка "Удалить заметку"
Widget deleteNoteButton() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
          color: ColorLibrary.mainGray,
          borderRadius: BorderRadius.circular(12)
      ),
      width: 189,
      height: 50,
      child: Center(
        child: Text(
          'Удалить заметку',
          style: StyleLibrary.goToToday,
        ),
      ),
    ),
  );
}