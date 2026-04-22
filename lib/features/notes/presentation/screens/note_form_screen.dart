import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_list/core/data/classes/note_class.dart';
import 'package:notes_list/core/data/enums/colors.dart';
import 'package:notes_list/core/data/enums/note_types.dart';
import 'package:notes_list/core/statics/color_library.dart';
import 'package:notes_list/features/notes/providers/note_form_provider.dart';

import '../../../../core/data/classes/list_item_class.dart';
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

  /// Ключ формы
  final _formKey = GlobalKey<FormState>();

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
        dateController.text = ref.read(noteFormProvider.notifier).dateToString(note.date);
        colorController.text = ref.read(noteFormProvider.notifier).getDisplayNameByEnum(note.color);
      } else {
        isCreate = true;
        final initialDate = args?['date'] as DateTime? ?? DateTime.now();
        note = NoteClass(
          name: '',
          date: initialDate,
          color: CardColors.Red,
          type: NoteTypes.Text,
          listItems: [],
        );
        dateController.text = ref.read(noteFormProvider.notifier).dateToString(initialDate);
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
    final notifier = ref.read(noteFormProvider.notifier);

    final isEdit = !isCreate;

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
                  key: _formKey,
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
              child: isEdit ? buttonsForEdit(
                notifier,
                nameController,
                descriptionController,
                dateController,
                colorController,
                _formKey,
                null,
                [],
              ) : saveButton(
                context,
                notifier,
                nameController: nameController,
                descriptionController: descriptionController,
                dateController: dateController,
                colorController: colorController,
                formKey: _formKey,
                time: null,
                listItems: [],
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonsForEdit(
      NoteFormNotifier notifier,
      TextEditingController nameController,
      TextEditingController descriptionController,
      TextEditingController dateController,
      TextEditingController colorController,
      GlobalKey<FormState> formKey,
      DateTime? time,
      List<ListItemClass> listItems,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        deleteNoteButton(context, note, notifier),
        saveButtonMini(
          context: context,
          onPressed: () async {
            final name = nameController.text;
            final description = descriptionController.text.isEmpty
                ? null
                : descriptionController.text;
            final date = notifier.dateToDateTime(dateController.text);
            final color = notifier.getColorEnumByName(colorController.text);

            final updatedNote = note.copyWith(
              name: name,
              description: description,
              date: date,
              color: color,
              time: time,
              listItems: listItems,
            );

            await notifier.updateNote(note, updatedNote);
            if (context.mounted) Navigator.pop(context);
          },
        ),
      ],
    );
  }
}