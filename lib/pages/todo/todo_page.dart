import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/collections/todo.dart';
import 'package:flutter_todo_app/model/services/todo_service.dart';
import 'package:flutter_todo_app/pages/todo/widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({
    super.key,
    required this.todoService,
  });

  // TODO DIコンテナで管理できないか？
  final TodoService todoService;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();

    // Todo一覧取得
    Future(() async {
      _refreshTodos(await widget.todoService.findTodos());
    });

    // Todo一覧の監視
    widget.todoService.getTodoStream().listen(_refreshTodos);
  }

  void _refreshTodos(List<Todo> todos) {
    setState(() {
      _todos
        ..clear()
        ..addAll(todos);
    });
  }

  Future<void> _addTodo(String todoName) async {
    await widget.todoService.addTodo(todoName);

    setState(() {
      _controller.clear();
    });
  }

  Future<void> _deleteTodo(int id) async {
    await widget.todoService.deleteTodo(id);
  }

  Future<void> _changeIsDone(int id) async {
    await widget.todoService.changeIsDone(id);
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
