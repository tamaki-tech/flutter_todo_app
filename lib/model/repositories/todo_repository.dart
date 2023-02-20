import 'dart:async';

import 'package:flutter_todo_app/app/core/exceptions.dart';
import 'package:flutter_todo_app/model/collections/todo.dart';
import 'package:isar/isar.dart';

class TodoRepository {
  TodoRepository({required this.isar}) {
    isar.todos.watchLazy().listen((_) async {
      _todoController.sink.add(await findAll());
    });
  }

  final Isar isar;

  final _todoController = StreamController<List<Todo>>.broadcast();

  /// ToDo Stream getter
  Stream<List<Todo>> get stream => _todoController.stream;

  FutureOr<List<Todo>> findAll() async {
    final builder = isar.todos.where();
    return builder.findAll();
  }

  Future<Todo> getTodoById(int id) async {
    Todo? todo = await isar.todos.get(id);

    if (todo == null) {
      throw NoResultFoundException();
    }

    return todo;
  }

  FutureOr<void> add(String name) {
    final newTodo = Todo()..name = name;

    return isar.writeTxn(() async {
      await isar.todos.put(newTodo);
    });
  }

  FutureOr<bool> delete(int id) async {
    Todo todo = await getTodoById(id);

    return isar.writeTxn(() {
      return isar.todos.delete(todo.id);
    });
  }

  FutureOr<void> update(Todo todo) async {
    Todo target = await getTodoById(todo.id);

    target
      ..id = todo.id
      ..name = todo.name
      ..isDone = todo.isDone;

    return isar.writeTxn(() async {
      await isar.todos.put(target);
    });
  }
}
