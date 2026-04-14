import 'package:flutter/material.dart';
import '../features/notes/presentation/screens/main_screen.dart';
import '../features/notes/presentation/screens/note_form_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ежедневник',
      routes: {
        '/': (context) => const MainScreenClass(),
        '/noteFormScreen': (context) => const NoteFormScreenClass(),
      },
      initialRoute: '/',
    );
  }
}