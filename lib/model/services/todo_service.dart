import 'package:flutter_todo_app/model/collections/todo.dart';
import 'package:flutter_todo_app/model/repositories/todo_repository.dart';

class TodoService {
  const TodoService({required this.todoRepository});

  final TodoRepository todoRepository;

  Stream<List<Todo>> getTodoStream() {
    return todoRepository.stream;
  }

  Future<List<Todo>> findTodos() async {
    return await todoRepository.findAll();
  }

  Future<void> changeIsDone(int id) async {
    Todo todo = await todoRepository.getTodoById(id);
    todo.isDone = !todo.isDone;
    await todoRepository.update(todo);
  }

  Future<void> addTodo(String name) async {
    await todoRepository.add(name);
  }

  Future<void> deleteTodo(int id) async {
    await todoRepository.delete(id);
  }
}
