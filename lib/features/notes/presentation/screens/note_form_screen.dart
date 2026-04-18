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
  ConsumerState<NoteFormScreenClass> createState() =>
      _NoteFormScreenClassState();
}

class _NoteFormScreenClassState extends ConsumerState<NoteFormScreenClass> {
  /// Флаг – создание новой заметки или редактирование
  late bool isCreate;

  /// Заметка (для редактирования)
  late NoteClass note;

  /// Контроллеры полей
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  late TextEditingController colorController;

  /// Флаг, чтобы не переинициализировать контроллеры при каждом didChangeDependencies
  bool _controllersInitialized = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();
    colorController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (!_controllersInitialized) {
      _controllersInitialized = true;

      if (args?['note'] != null) {
        note = args?['note'] as NoteClass;
        isCreate = false;
        nameController.text = note.name ?? '';
        descriptionController.text = note.description ?? '';
        dateController.text = ref.read(noteFormProvider.notifier).toFormatDate(note.date);
        colorController.text = ref.read(noteFormProvider.notifier).getDisplayName(note.color);
      } else {
        isCreate = true;
        final initialDate = args?['date'] as DateTime? ?? DateTime.now();
        note = NoteClass(
          name: '',
          date: initialDate,
          color: CardColors.Red,
          type: NoteTypes.Text,
        );
        dateController.text = ref.read(noteFormProvider.notifier).toFormatDate(initialDate);
        colorController.text = 'Красный';
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (args?['note'] != null) {
          ref.read(noteFormProvider.notifier).loadNote(note);
        }
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteFormProvider);
    final notifier = ref.read(noteFormProvider.notifier);

    final bool isEdit = state.note != null;

    return Scaffold(
      backgroundColor: ColorLibrary.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 45),
        child: Column(
          children: [
            titleNoteForm(context, isEdit),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      fieldWidget(
                        context,
                        nameController,
                        FieldTypes.name,
                        notifier,
                      ),
                      const SizedBox(height: 10),
                      fieldWidget(
                        context,
                        descriptionController,
                        FieldTypes.description,
                        notifier,
                      ),
                      const SizedBox(height: 10),
                      fieldWidget(
                        context,
                        dateController,
                        FieldTypes.date,
                        notifier,
                      ),
                      const SizedBox(height: 10),
                      fieldWidget(
                        context,
                        colorController,
                        FieldTypes.color,
                        notifier,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
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
        saveButtonMini(),
      ],
    );
  }
}