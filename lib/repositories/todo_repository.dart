import 'dart:async';

import 'package:flutter_todo_app/collections/todo.dart';
import 'package:isar/isar.dart';

class TodoRepository {
  TodoRepository({required this.isar}) {
    isar.todos.watchLazy().listen((_) async {
      if (!isar.isOpen) return;
      if (_todoController.isClosed) return;
      _todoController.sink.add(await findTodos());
    });
  }

  final Isar isar;

  final _todoController = StreamController<List<Todo>>.broadcast();
  Stream<List<Todo>> get todoStream => _todoController.stream;

  void dispose() {
    _todoController.close();
  }

  /// Todo取得
  FutureOr<List<Todo>> findTodos() async {
    if (!isar.isOpen) {
      return [];
    }

    final builder = isar.todos.where();

    final todos = builder.findAll();

    return todos;
  }

  /// ToDo追加
  FutureOr<void> addTodo(String name) {
    if (!isar.isOpen) {
      return Future<void>(() {});
    }

    final newTodo = Todo()..name = name;

    return isar.writeTxn(() async {
      await isar.todos.put(newTodo);
    });
  }

  /// ToDo削除
  FutureOr<bool> deleteTodo(int id) {
    if (!isar.isOpen) {
      return false;
    }

    return isar.writeTxn(() {
      return isar.todos.delete(id);
    });
  }
}
