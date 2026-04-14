import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/color_library.dart';
import '../../providers/main_provider.dart';
import '../../providers/note_states.dart';

/// Открытие календаря для основной страницы
void openMainCalendar(BuildContext context, MainState state, MainNotifier notifier) {
  DateTime currentDate = state.currentDate;
  DateTime displayedMonth = state.currentDate;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // Первый день месяца
          final firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month, 1);
          // Количество дней в месяце
          final daysInMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
          // День недели первого дня
          final firstWeekday = firstDayOfMonth.weekday;
          // Количество пустых ячеек в первом дне
          final offset = firstWeekday - 1;
          // Количество недель в месяце
          final weeksInMonth = ((offset + daysInMonth) / 7).ceil();
          // Высота недели
          const weekHeight = 45;
          // Высота контейнера
          final containerHeight = 60 + (weeksInMonth * weekHeight);
          // Ограничение размеров контейнера
          final calculatedHeight = containerHeight.clamp(60 + (4 * weekHeight), 60 + (6 * weekHeight)).toDouble();

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              width: 200,
              height: calculatedHeight,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, size: 18),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            displayedMonth = DateTime(displayedMonth.year, displayedMonth.month - 1, 1);
                          });
                        },
                      ),
                      Text(
                        '${_getMonthName(displayedMonth.month)} ${displayedMonth.year}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorLibrary.mainGray),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, size: 18),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 1);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс']
                        .map((day) => Expanded(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorLibrary.mainGray),
                      ),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      itemCount: weeksInMonth * 7,
                      itemBuilder: (context, index) {
                        if (index < offset || index >= offset + daysInMonth) {
                          return Container();
                        }

                        final dayOfMonth = index - offset + 1;
                        final day = DateTime(displayedMonth.year, displayedMonth.month, dayOfMonth);

                        final isSelected = day.day == currentDate.day &&
                            day.month == currentDate.month &&
                            day.year == currentDate.year;

                        final now = DateTime.now();
                        final isToday = day.day == now.day && day.month == now.month && day.year == now.year;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentDate = day;
                            });
                            notifier.updateDataAfterTapOnCalendar(currentDate);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? ColorLibrary.mainGray : (isToday ? ColorLibrary.currentDate : null),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$dayOfMonth',
                              style: TextStyle(
                                fontSize: 10,
                                color: isSelected || isToday ? ColorLibrary.white : ColorLibrary.text,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

/// Метод, возвращающий название месяца
String _getMonthName(int month) {
  const months = ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'];
  return months[month - 1];
}
