import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';
import 'package:notes_list/features/notes/providers/note_form_provider.dart';

import '../../../../../core/statics/color_library.dart';
import '../alert_dialog/cancel_alert_dialog.dart';

/// Тайтл страницы с формой для заполнения заметки
Widget titleNoteForm(BuildContext context, bool isEdit) {
  return Column(
    children: [
      SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showCancelAlertDialog(context, isEdit);
              },
              child: SizedBox(
                height: 20,
                width: 20,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorLibrary.mainGray,
                ),
              )
            ),
            SizedBox(width: 15,),
            Text(
              isEdit ? 'Редактирование' : 'Создание',
              style: StyleLibrary.title,
            ),
          ],
        ),
      )
    ],
  );
}