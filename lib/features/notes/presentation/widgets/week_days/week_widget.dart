import 'package:flutter/material.dart';
import 'package:notes_list/features/notes/presentation/widgets/week_days/weekday.dart';

import '../../../providers/main_provider.dart';
import '../../../providers/note_states.dart';

/// Виджет недели
Widget weekWidget(MainState state, MainNotifier notifier) {
  return SizedBox(
    height: 70,
    child: GestureDetector(
      onHorizontalDragEnd: (details) {
        final velocity = details.primaryVelocity;
        if (velocity == null) return;

        if (velocity > 0) {
          notifier.updateDataAfterLeftSwipe(state.currentDate);
        } else if (velocity < 0) {
          notifier.updateDataAfterRightSwipe(state.currentDate);
        }
      },
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: state.currentWeek.map((date) => weekday(
                                                date,
                                                state,
                                                notifier
                                                )).toList(),
        ),
      ),
    ),
  );
}