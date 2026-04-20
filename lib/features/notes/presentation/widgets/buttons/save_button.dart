import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/style_library.dart';

import '../../../../../core/data/classes/list_item_class.dart';
import '../../../../../core/data/classes/note_class.dart';
import '../../../../../core/data/enums/colors.dart';
import '../../../../../core/data/enums/note_types.dart';
import '../../../../../core/statics/color_library.dart';
import '../../../providers/note_form_provider.dart';

/// Кнопка "Сохранить"
Widget saveButton(
    BuildContext context,
    NoteFormNotifier notifier, {
      required TextEditingController nameController,
      required TextEditingController descriptionController,
      required TextEditingController dateController,
      required TextEditingController colorController,
      required GlobalKey<FormState> formKey,
      DateTime? time,
      required List<ListItemClass> listItems,
    }) {
  return GestureDetector(
    onTap: () {
      if (formKey.currentState?.validate() ?? false) {
        final name = nameController.text;
        final description = descriptionController.text.isEmpty ? null : descriptionController.text;
        final date = notifier.dateToDateTime(dateController.text);
        final color = notifier.getColorEnumByName(colorController.text);

        final newNote = NoteClass(
          name: name,
          description: description,
          date: date,
          color: color,
          type: NoteTypes.Text,
          time: time,
          listItems: listItems,
        );
        notifier.addNoteAndCloseScreen(context, newNote);
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: ColorLibrary.mainGray,
        borderRadius: BorderRadius.circular(12),
      ),
      width: 372,
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