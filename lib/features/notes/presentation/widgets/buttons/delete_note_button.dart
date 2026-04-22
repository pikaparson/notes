import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';

import '../../../../../core/data/classes/note_class.dart';
import '../../../../../core/statics/color_library.dart';
import '../../../providers/note_form_provider.dart';

/// Кнопка "Удалить заметку"
Widget deleteNoteButton(BuildContext context, NoteClass note, NoteFormNotifier notifier,) {
  return GestureDetector(
    onTap: () {
      notifier.deleteNote(context, note);
    },
    child: Container(
      decoration: BoxDecoration(
          color: ColorLibrary.mainGray,
          borderRadius: BorderRadius.circular(12)
      ),
      width: 189,
      height: 50,
      child: Center(
        child: Text(
          'Удалить заметку',
          style: StyleLibrary.goToToday,
        ),
      ),
    ),
  );
}