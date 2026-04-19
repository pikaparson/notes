import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:notes_list/core/statics/color_library.dart';
import 'package:notes_list/core/statics/style_library.dart';
import '../../../../../core/data/enums/colors.dart';
import '../../../providers/note_form_provider.dart';
import '../form_calendar_widget.dart';
import 'field_types.dart';

/// Виджет-поле для ввода
Widget fieldWidget(
    BuildContext context,
    TextEditingController controller,
    FieldTypes type,
    NoteFormNotifier notifier,
    ) {

  // Идентификатор поля для ввода
  final GlobalKey textFieldKey = GlobalKey();

  // Идентификатор кнопки поля для выбора цвета
  final GlobalKey colorSuffixKey = GlobalKey();

  // Функция открытия выпадающего меню
  Future<void> showColorMenu() async {

    final RenderBox? fieldBox = textFieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (fieldBox == null) return;
    final Offset fieldOffset = fieldBox.localToGlobal(Offset.zero);
    final Size fieldSize = fieldBox.size;

    final RelativeRect position = RelativeRect.fromLTRB(
      fieldOffset.dx,
      fieldOffset.dy + fieldSize.height,
      fieldOffset.dx + fieldSize.width,
      fieldOffset.dy + fieldSize.height,
    );

    final List<CardColors> colors = CardColors.values;

    final String? selectedName = await showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: ColorLibrary.mainGray),
      ),
      constraints: BoxConstraints(
        maxWidth: fieldSize.width,
        minWidth: fieldSize.width
      ),
      elevation: 4,
      color: ColorLibrary.white,
      items: colors.map((cardColor) {
        final String name = notifier.getDisplayNameByEnum(cardColor);
        final Color color = notifier.getColorByEnum(cardColor);
        final bool isSelected = controller.text == name;
        return PopupMenuItem<String>(
          value: name,
          child: Row(
            children: [
              Container(width: 20, height: 20, color: color),
              const SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );

    if (selectedName != null && selectedName != controller.text) {
      controller.text = selectedName;
    }
  }

  // Возвращение названия поля
  Widget getNameField() {
    switch (type) {
      case FieldTypes.name:
        return Row(
          children: [
            Text('Название заметки', style: StyleLibrary.main),
            const SizedBox(width: 5),
            Text('*', style: StyleLibrary.main.copyWith(color: ColorLibrary.redCard)),
          ],
        );
      case FieldTypes.description:
        return Row(
          children: [
            Text('Описание заметки', style: StyleLibrary.main),
          ],
        );
      case FieldTypes.date:
        return Row(
          children: [
            Text('Дата заметки', style: StyleLibrary.main),
            const SizedBox(width: 5),
            Text('*', style: StyleLibrary.main.copyWith(color: ColorLibrary.redCard)),
          ],
        );
      case FieldTypes.color:
        return Row(
          children: [
            Text('Цвет карточки', style: StyleLibrary.main),
          ],
        );
      case FieldTypes.type:
        return const SizedBox.shrink();
      case FieldTypes.time:
        return const SizedBox.shrink();
    }
  }

  // Возвращение кнопки поля
  Widget? getIcon() {
    if (type == FieldTypes.date) {
      return GestureDetector(
        onTap: () {
          openFormCalendar(context, controller, notifier);
        },
        child: const SizedBox(
          height: 20,
          width: 20,
          child: Icon(
            Icons.date_range,
            color: ColorLibrary.mainGray,
          ),
        ),
      );
    } else if (type == FieldTypes.color) {
      return GestureDetector(
        key: colorSuffixKey,
        onTap: showColorMenu,
        child: Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10),
          color: notifier.getCurrentColor(controller.text),
        ),
      );
    }
    return null;
  }

  // Валидация поля названия заметки
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле обязательно для заполнения';
    }
    return null;
  }

  // Валидация поля даты
  String? dateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не заполнено';
    }

    final parts = value.split('.');
    if (parts.length != 3) {
      return 'Поле не заполнено';
    }

    final dayStr = parts[0];
    final monthStr = parts[1];
    final yearStr = parts[2];

    final day = int.tryParse(dayStr);
    final month = int.tryParse(monthStr);
    final year = int.tryParse(yearStr);

    if (year == null || year < 2000) {
      return 'Поле не заполнено';
    }

    // Проверяем диапазоны
    if (month == null || month < 1 || month > 12) {
      return 'Месяц должен быть от 01 до 12';
    }

    // Проверяем февраль
    if (month == 2) {
      final isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      if (isLeapYear && (day == null || day > 29)) {
        return 'В високосном году в феврале не больше 29 дней';
      }
      if (!isLeapYear && (day == null || day > 28)) {
        return 'В невисокосном году в феврале не больше 28 дней';
      }
    }

    // Проверяем количество дней в месяце
    final daysInMonth = DateTime(year, month + 1, 0).day;
    if (day == null || day < 1 || day > daysInMonth) {
      return 'В этом месяце от 01 до $daysInMonth дней';
    }

    // Проверяем 30-дневные месяцы
    if ([4, 6, 9, 11].contains(month) && (day == null || day > 30)) {
      return 'В этом месяце не больше 30 дней';
    }

    // Проверяем 31-дневные месяцы
    if ([1, 3, 5, 7, 8, 10, 12].contains(month) && (day == null || day > 31)) {
      return 'В этом месяце не больше 31 дня';
    }

    return null;
  }

  // Выбор валидатора
  String? validator(String? value) {
    if (type == FieldTypes.name) {
      return nameValidator(value);
    }
    if (type == FieldTypes.date) {
      return dateValidator(value);
    }
    return null;
  }

  // Выбор маски
  MaskTextInputFormatter? inputFormatter() {
    if (type == FieldTypes.date) {
      return MaskTextInputFormatter(
          mask: '##.##.####',
          filter: {
            "#": RegExp(r'[0-9]')
          },
          type: MaskAutoCompletionType.lazy
      );
    }
    return null;
  }

  // Возвращение поля
  Widget field(FieldTypes type) {
    return TextFormField(
      key: textFieldKey,
      controller: controller,
      validator: validator,
      inputFormatters: [?inputFormatter()],
      autovalidateMode: AutovalidateMode.always,
      readOnly: type == FieldTypes.color,
      minLines: 1,
      maxLines: type == FieldTypes.description ? 5 : 1,
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
        errorBorder: OutlineInputBorder(
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
      const SizedBox(height: 5),
      field(type),
    ],
  );
}