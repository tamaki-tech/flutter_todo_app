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

    widget.todoRepository.todoStream.listen(_refresh);

    () async {
      _refresh(await widget.todoRepository.findTodos());
    }();
  }

  void _refresh(List<Todo> todos) {
    if (!mounted) return;

    setState(() {
      _todos
        ..clear()
        ..addAll(todos);
    });
  }

  Future<void> _addTodo(String todoName) async {
    await widget.todoRepository.addTodo(todoName);
  }

  Future<void> _deleteTodo(int id) async {
    await widget.todoRepository.deleteTodo(id);
  }

  void _changeIsDone(int id) {
    setState(() {
      Todo todo = _todos.singleWhere((todo) => todo.id == id);
      todo.isDone = !todo.isDone;
    });
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
