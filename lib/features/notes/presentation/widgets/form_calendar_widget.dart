import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/color_library.dart';
import '../../providers/note_form_provider.dart';

/// Открытие календаря для основной страницы
void openFormCalendar(
    BuildContext context,
    TextEditingController controller,
    NoteFormNotifier notifier,
    ) {

  /// Переданный день
  int day;
  /// Переданный месяц
  int month;
  /// Переданный год
  int year;
  /// Текст контроллера
  final text = controller.text;

  if (text.isEmpty) {
    final now = DateTime.now();
    day = now.day;
    month = now.month;
    year = now.year;
  } else {
    final parts = text.split('.');
    if (parts.length == 3) {
      day = int.tryParse(parts[0]) ?? DateTime.now().day;
      month = int.tryParse(parts[1]) ?? DateTime.now().month;
      year = int.tryParse(parts[2]) ?? DateTime.now().year;
    } else {
      final now = DateTime.now();
      day = now.day;
      month = now.month;
      year = now.year;
    }
  }

  /// Выбранная дата, отображающаяся в календаре
  DateTime displayedMonth = DateTime(year, month, 1);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // Первый день месяца выбранной даты
          final firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month, 1);
          // Количество дней в месяце
          final daysInMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
          // День недели первого дня
          final firstWeekday = firstDayOfMonth.weekday;
          // Количество пустых дней в неделе перед первым днем
          final offset = firstWeekday - 1;
          // Количество недель в месяце
          final weeksInMonth = ((offset + daysInMonth) / 7).ceil();
          // Высота недели
          const weekHeight = 45;
          // Базовая высота контейнера
          final containerHeight = 60 + (weeksInMonth * weekHeight);
          // Ограничения высоты контейнера в зависимости от количества недель
          final calculatedHeight = containerHeight
              .clamp(60 + (4 * weekHeight), 60 + (6 * weekHeight))
              .toDouble();

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
                            displayedMonth = DateTime(
                                displayedMonth.year,
                                displayedMonth.month - 1, 1
                            );
                          });
                        },
                      ),
                      Text(
                        '${_getMonthName(displayedMonth.month)} ${displayedMonth.year}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorLibrary.mainGray,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, size: 18),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            displayedMonth = DateTime(
                                displayedMonth.year,
                                displayedMonth.month + 1,
                                1
                            );
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
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorLibrary.mainGray,
                        ),
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
                        final newDay = DateTime(
                            displayedMonth.year,
                            displayedMonth.month,
                            dayOfMonth
                        );

                        final isSelected = newDay.day == day &&
                            newDay.month == month &&
                            newDay.year == year;

                        return GestureDetector(
                          onTap: () {
                            final formattedDate = notifier.dateToString(newDay);
                            controller.text = formattedDate;
                            controller.notifyListeners();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? ColorLibrary.mainGray : null,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$dayOfMonth',
                              style: TextStyle(
                                fontSize: 10,
                                color: isSelected ? ColorLibrary.white : ColorLibrary.text,
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
  const months = [
    'Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн',
    'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'
  ];
  return months[month - 1];
}