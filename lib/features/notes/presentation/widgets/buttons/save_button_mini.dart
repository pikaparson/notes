import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';

import '../../../../../core/data/classes/note_class.dart';
import '../../../../../core/statics/color_library.dart';
import '../../../providers/note_form_provider.dart';

/// Маленькая кнопка "Сохранить"
Widget saveButtonMini(BuildContext context,
    NoteClass oldNote,
    NoteClass updatedNote,
    NoteFormNotifier notifier
    ) {
  return GestureDetector(
    onTap: () {
      notifier.updateNote(oldNote, updatedNote);
      Navigator.pop(context);
    },
    child: Container(
      decoration: BoxDecoration(
        color: ColorLibrary.mainGray,
        borderRadius: BorderRadius.circular(12)
      ),
      width: 155,
      height: 50,
      child: Center(
        child: Text(
          'Сохранить',
          style: StyleLibrary.goToToday,
        ),
      ),
    ),
  );
}