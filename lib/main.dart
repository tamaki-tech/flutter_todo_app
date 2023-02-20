import 'package:flutter/material.dart';
import 'package:flutter_todo_app/app/app.dart';
import 'package:flutter_todo_app/model/collections/todo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // runApp実行前にFlutter Engineの機能を利用する場合に実行が必要。
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open([TodoSchema], directory: dir.path);

  runApp(App(isar: isar));
}
