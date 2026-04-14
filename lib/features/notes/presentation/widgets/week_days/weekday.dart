import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';
import '../../../../../core/statics/color_library.dart';
import '../../../providers/main_provider.dart';
import '../../../providers/note_states.dart';

/// День недели
Widget weekday(DateTime date, MainState state, MainNotifier notifier) {
  List<String> weekdays = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];
  bool isCurrent = date.day == state.currentDate.day;
  bool isToday = date.day == state.today.day && date.month == state.today.month;

  return GestureDetector(
    onTap: () {
      notifier.updateDataAfterTapOnWeek(date);
    },
    child: Column(
      children: [
        day('${date.day}', isCurrent),
        const SizedBox(height: 5),
        Text(
          isToday ? 'сегодня' : weekdays[date.weekday - 1],
          style: StyleLibrary.main,
        )
      ],
    ),
  );
}

/// День
Widget day(String day, bool isCurrent) {
  return Container(
    width: 45,
    height: 45,
    decoration: BoxDecoration(
      color: isCurrent ? ColorLibrary.currentDate : ColorLibrary.mainGray,
      borderRadius: const BorderRadius.all(Radius.circular(100)),
    ),
    child: Center(
      child: Text(
        day,
        style: StyleLibrary.nameOfDayOfWeek,
      ),
    ),
  );
}