import 'package:flutter/material.dart';
import 'package:flutter_todo_app/collections/todo.dart';
import 'package:flutter_todo_app/repositories/todo_repository.dart';
import 'package:flutter_todo_app/pages/todo/widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.todoRepository});

  final TodoRepository todoRepository;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();

    // Todo一覧の監視
    widget.todoRepository.todoStream.listen(_refreshTodos);

    Future(() async {
      _refreshTodos(await widget.todoRepository.findTodos());
    });
  }

  void _refreshTodos(List<Todo> todos) {
    setState(() {
      _todos
        ..clear()
        ..addAll(todos);
    });
  }

  Future<void> _addTodo(String todoName) async {
    await widget.todoRepository.addTodo(todoName);

    setState(() {
      _controller.clear();
    });
  }

  Future<void> _deleteTodo(int id) async {
    await widget.todoRepository.deleteTodo(id);
  }

  Future<void> _changeIsDone(Todo todo) async {
    await widget.todoRepository.updateTodo(todo, !todo.isDone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ToDo"),
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => _addTodo(_controller.text),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _todos.length,
              itemBuilder: (BuildContext context, int index) {
                return TodoItem(
                  todo: _todos[index],
                  onDeleteTodo: _deleteTodo,
                  onChangeIsDone: _changeIsDone,
                );
              },
            )
          ],
        ));
  }
}
