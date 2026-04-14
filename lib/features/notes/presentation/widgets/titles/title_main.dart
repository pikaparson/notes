import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';
import '../../../../../core/statics/color_library.dart';
import '../../../providers/main_provider.dart';
import '../../../providers/note_states.dart';
import '../main_calendar_widget.dart';

/// Тайтл основной страницы
Widget titleMain(DateTime date, BuildContext context, MainState state, MainNotifier notifier) {
  String day = date.day >= 10 ? '${date.day}' : '0${date.day}';
  String month = date.month >= 10 ? '${date.month}' : '0${date.month}';

  return Column(
    children: [
      SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Заметки',
              style: StyleLibrary.title,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    /// ToDo: виджет сортировки, передача в функцию
                  },
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Icon(
                      Icons.sort,
                      color: ColorLibrary.mainGray,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    openMainCalendar(context, state, notifier);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Icon(
                          Icons.date_range,
                          color: ColorLibrary.mainGray,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$day.$month',
                        style: StyleLibrary.date,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ],
  );
}