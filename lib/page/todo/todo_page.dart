import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/Todo.dart';
import 'package:flutter_todo_app/page/todo/widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Todo> _todos = [];

  void _addTodo(String todoName) {
    setState(() {
      _todos.add(Todo(id: _todos.length + 1, name: todoName));
      _controller.clear();
    });
  }

  void _deleteTodo(int id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
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
