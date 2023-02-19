import 'package:flutter/material.dart';
import 'package:flutter_todo_app/app.dart';
import 'package:flutter_todo_app/collections/todo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // TODO 何者なのか調べる
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open([TodoSchema], directory: dir.path);

  runApp(App(
    isar: isar,
  ));
}
