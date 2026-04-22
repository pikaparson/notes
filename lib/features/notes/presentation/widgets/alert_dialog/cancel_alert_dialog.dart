import 'package:flutter/material.dart';
import '../../../../../core/statics/style_library.dart';

void showCancelAlertDialog(BuildContext context, bool isEdit) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text("Отмена", style: StyleLibrary.dialogName),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        content: Container(
          width: double.infinity,
          child: Text(
            isEdit ?
            "Вы уверены, что хотите прекратить редактирование заметки? Внесенные изменения не сохранятся." :
            "Вы уверены, что хотите отменить создание заметки? Внесенные данные не сохранятся.",
            style: StyleLibrary.dialogContent,
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text("Вернуться", style: StyleLibrary.dialogButton),
                onPressed: () => Navigator.pop(dialogContext),
              ),
              TextButton(
                child: Text("Да", style: StyleLibrary.dialogButton),
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}