import 'package:flutter/material.dart';
import 'package:flutter_todo_app/collections/todo.dart';
import 'package:flutter_todo_app/pages/todo/todo_page.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open([TodoSchema], directory: dir.path);

  runApp(App(
    isar: isar,
  ));
}

class App extends StatelessWidget {
  const App({super.key, required this.isar});

  final Isar isar;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const TodoPage(),
    );
  }
}
