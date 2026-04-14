import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';

import '../../../../../core/statics/color_library.dart';
import '../../../providers/main_provider.dart';
import '../../../providers/note_states.dart';

/// Кнопка "Перейти на сегодняшний день"
Widget goToTodayButton(MainNotifier notifier) {
  return GestureDetector(
    onTap: () {
      notifier.loadToday();
    },
    child: Container(
      decoration: BoxDecoration(
          color: ColorLibrary.mainGray,
          borderRadius: BorderRadius.circular(7)
      ),
      width: 317,
      height: 30,
      child: Center(
        child: Text(
          'Перейти на сегодняшний день',
          style: StyleLibrary.goToToday,
        ),
      ),
    ),
  );
}