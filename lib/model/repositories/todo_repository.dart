import 'dart:async';

import 'package:flutter_todo_app/model/collections/todo.dart';
import 'package:isar/isar.dart';

class TodoRepository {
  TodoRepository({required this.isar}) {
    isar.todos.watchLazy().listen((_) async {
      _todoController.sink.add(await findTodos());
    });
  }

  final Isar isar;

  final _todoController = StreamController<List<Todo>>.broadcast();

  /// ToDo Stream getter
  Stream<List<Todo>> get todoStream => _todoController.stream;

  /// ToDo一覧取得
  FutureOr<List<Todo>> findTodos() async {
    final builder = isar.todos.where();
    return builder.findAll();
  }

  /// ToDo追加
  FutureOr<void> addTodo(String name) {
    final newTodo = Todo()..name = name;

    return isar.writeTxn(() async {
      await isar.todos.put(newTodo);
    });
  }

  /// ToDo削除
  FutureOr<bool> deleteTodo(int id) {
    return isar.writeTxn(() {
      return isar.todos.delete(id);
    });
  }

  /// ToDo更新
  FutureOr<void> updateTodo(Todo todo, bool isDone) {
    todo.isDone = isDone;

    return isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }
}
