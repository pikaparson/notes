import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_list/src/my_app.dart';
import 'core/hive/init_hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(ProviderScope(
    child: MyApp()
  ));
}