import 'package:flutter/material.dart';
import 'package:notes_list/features/notes/providers/main_provider.dart';
import '../../../../../core/statics/color_library.dart';

Widget addNewNoteButton(BuildContext context, MainNotifier notifier, DateTime currentDate) {
  return GestureDetector(
    onTap: () {
      notifier.openFormScreenToAddNote(context, currentDate);
    },
    child: Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 40),
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            color: ColorLibrary.mainGray,
            borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        child: Icon(Icons.add, color: ColorLibrary.white, size: 50,),
      ),
    ),
  );
}