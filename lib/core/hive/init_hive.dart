import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../data/classes/note_class.dart';
import '../data/enums/colors.dart';
import '../data/enums/note_types.dart';

/// Инициализация hive
Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteClassAdapter());
  Hive.registerAdapter(ColorsAdapter());
  Hive.registerAdapter(NoteTypesAdapter());
}