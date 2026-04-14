import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_list/core/data/classes/note_class.dart';
import 'package:notes_list/core/data/enums/colors.dart';
import 'package:notes_list/core/data/enums/note_types.dart';
import 'package:notes_list/core/statics/color_library.dart';
import 'package:notes_list/features/notes/providers/note_form_provider.dart';

import '../widgets/buttons/delete_note_button.dart';
import '../widgets/buttons/save_button.dart';
import '../widgets/buttons/save_button_mini.dart';
import '../widgets/field_widget/field_types.dart';
import '../widgets/field_widget/field_widget.dart';
import '../widgets/titles/title_note_form.dart';

/// Страница с формой для заполнения
class NoteFormScreenClass extends ConsumerStatefulWidget {
  const NoteFormScreenClass({super.key});

  @override
  ConsumerState<NoteFormScreenClass> createState() => _NoteFormScreenClassState();
}

class _NoteFormScreenClassState extends ConsumerState<NoteFormScreenClass> {

  /// Страница для редактирования
  late bool isCreate;

  /// Заметка
  late NoteClass note;

  /// Дата азметки для заполнения
  DateTime date = DateTime.now();

  /// Создание страницы
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args?['note'] != null) {
      note = args?['note'] as NoteClass;
      date = note.date ?? DateTime.now();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(noteFormProvider.notifier).loadNote(note);
      });
    } else {
      date = args?['date'] as DateTime? ?? DateTime.now();
      note = NoteClass(
        name: '',
        date: date,
        color: CardColors.Red,
        type: NoteTypes.Text,
      ); // или создайте пустую заметку с дефолтными значениями
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteFormProvider);
    final notifier = ref.read(noteFormProvider.notifier);

    bool isEdit = state.note != null;

    TextEditingController nameController = TextEditingController(
        text: note.name
    );
    TextEditingController descriptionController = TextEditingController(
      text: note.description
    );
    TextEditingController dateController = TextEditingController(
      text: notifier.toFormatDate(note.date),
    );
    TextEditingController colorController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    bool isList = false;

    return Scaffold(
      backgroundColor: ColorLibrary.white,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 45),
        child: Column(
          children: [
            titleNoteForm(context, isEdit),
            SizedBox(height: 20,),
            Expanded(
                child: SingleChildScrollView(
                  child: Form(
                      child: Column(
                        children: [
                          /// ToDo: сделать функцию, которая заполняет текст контроллеров, если передается заметка (note != null)
                          fieldWidgetClass(context, nameController, FieldTypes.name, date, notifier),
                          SizedBox(height: 10,),
                          fieldWidgetClass(context, descriptionController, FieldTypes.description, date, notifier),
                          SizedBox(height: 10,),
                          fieldWidgetClass(context, dateController, FieldTypes.date, date, notifier),
                          SizedBox(height: 10,),
                        ],
                      )
                  ),
                ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 45),
              child: isEdit ? buttonsForEdit() : saveButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonsForEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        deleteNoteButton(),
        saveButtonMini()
      ],
    );
  }
}

