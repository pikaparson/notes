import 'package:flutter/material.dart';
import 'package:notes_list/core/data/classes/note_class.dart';
import 'package:notes_list/features/notes/providers/note_form_provider.dart';
import '../../../../../core/statics/style_library.dart';
import '../../../providers/main_provider.dart';

void showDeleteNoteAlertDialog(BuildContext context, NoteClass note, MainNotifier? mainNotifier, NoteFormNotifier? noteFormNotifier) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Center(child: Text("Удалить заметку", style: StyleLibrary.dialogName,)),
        content: Text("Вы уверены, что хотите удалить заметку? Удаленную заметку восстановить нельзя.", style: StyleLibrary.dialogContent, softWrap: true,),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text("Отмена", style: StyleLibrary.dialogButton,),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
              ),
              TextButton(
                child: Text("Удалить", style: StyleLibrary.dialogButton,),
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  if (mainNotifier != null) {
                    await mainNotifier.deleteNote(note);
                  } else if (noteFormNotifier != null) {
                    await noteFormNotifier.deleteNote(context, note);
                  }
                },
              ),
            ],
          )
        ],
      );
    },
  );
}