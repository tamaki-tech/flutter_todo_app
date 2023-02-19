import 'dart:async';

import 'package:flutter_todo_app/collections/todo.dart';
import 'package:isar/isar.dart';

class TodoRepository {
  TodoRepository({required this.isar});

  final Isar isar;

  final _todoController = StreamController<List<Todo>>.broadcast();
  Stream<List<Todo>> get todoStream => _todoController.stream;

  FutureOr<void> addTodo(Todo todo) {
    if (!isar.isOpen) {
      return Future<void>(() {});
    }

    return isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  Future<bool> deleteTodo(Todo todo) {
    return isar.todos.delete(todo.id);
  }
}
