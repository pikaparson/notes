import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_list/core/statics/color_library.dart';
import 'package:notes_list/core/statics/style_library.dart';
import '../../../providers/note_form_provider.dart';
import '../form_calendar_widget.dart';
import 'field_types.dart';

/// Виджет-поле для ввода
Widget fieldWidgetClass(
    BuildContext context,
    TextEditingController controller,
    FieldTypes type,
    DateTime currentDate,
    NoteFormNotifier notifier
    ) {

  // Возвращение названия поля
  Widget getNameField() {
    switch (type) {
      case (FieldTypes.name):
        return Row(
          children: [
            Text('Название заметки', style: StyleLibrary.main,),
            SizedBox(
              width: 5,
            ),
            Text('*', style: StyleLibrary.main.copyWith(color: ColorLibrary.redCard),)
          ],
        );
      case (FieldTypes.description):
        return Row(
          children: [
            Text('Описание заметки', style: StyleLibrary.main,),
          ],
        );
      case (FieldTypes.date):
        return Row(
          children: [
            Text('Дата заметки', style: StyleLibrary.main,),
            SizedBox(
              width: 5,
            ),
            Text('*', style: StyleLibrary.main.copyWith(color: ColorLibrary.redCard),)
          ],
        );
      case (FieldTypes.color):
        return Row(
          children: [
            Text('Цвет карточки', style: StyleLibrary.main,),
          ],
        );
      case (FieldTypes.type):
        return Row(
          children: [
            Text('Тип заметки', style: StyleLibrary.main,),
          ],
        );
      case (FieldTypes.time):
        return Row(
          children: [
            Text('Время', style: StyleLibrary.main,),
          ],
        );
    }
  }

  // Возвращение кнопки поля
  Widget getIcon() {
    if (type == FieldTypes.date) {
      return GestureDetector(
        onTap: () {
          openFormCalendar(context, controller, currentDate, notifier);
        },
        child: SizedBox(
          height: 25,
          width: 25,
          child: Icon(
            Icons.date_range,
            color: ColorLibrary.mainGray,
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  // Возвращение поля
  Widget field(FieldTypes type) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorLibrary.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorLibrary.mainGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorLibrary.mainGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorLibrary.mainGray, width: 1.7),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 12),
        isDense: true,
        suffixIcon: getIcon(),
      ),

    );
  }

  return Column(
    children: [
      getNameField(),
      SizedBox(height: 5,),
      field(type)
    ],
  );
}