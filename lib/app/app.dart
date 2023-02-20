import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/todo/todo_page.dart';
import 'package:flutter_todo_app/model/repositories/todo_repository.dart';
import 'package:isar/isar.dart';

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
      home: TodoPage(
        todoRepository: TodoRepository(isar: isar),
      ),
    );
  }
}
