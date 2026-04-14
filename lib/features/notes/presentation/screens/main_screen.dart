import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_list/core/statics/color_library.dart';
import '../../providers/main_provider.dart';
import '../widgets/buttons/add_new_note_button.dart';
import '../widgets/buttons/go_to_today_button.dart';
import '../widgets/titles/title_main.dart';
import '../widgets/week_days/week_widget.dart';

/// Основная страница
class MainScreenClass extends ConsumerStatefulWidget {
  const MainScreenClass({super.key});

  @override
  ConsumerState<MainScreenClass> createState() => _MainScreenClassState();
}

class _MainScreenClassState extends ConsumerState<MainScreenClass> {

  /// Создание страницы
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mainProvider.notifier).loadToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mainProvider);
    final notifier = ref.read(mainProvider.notifier);
    final bool isToday = state.currentDate.year == state.today.year &&
        state.currentDate.month == state.today.month &&
        state.currentDate.day == state.today.day;

    return Scaffold(
      backgroundColor: ColorLibrary.white,
      floatingActionButton: addNewNoteButton(context, notifier, state.currentDate),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 45),
        child: Column(
          children: [
            titleMain(state.currentDate, context, state, notifier),
            weekWidget(state, notifier),
            if (!isToday) ...[
              SizedBox(
                height: 20,
              ),
              goToTodayButton(notifier),
              SizedBox(
                height: 20,
              ),
            ] else ...[
              SizedBox(
                height: 20 + 30 + 20 // 20 - промежуток перед и после кнопки, 30 - высота кнопки,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
