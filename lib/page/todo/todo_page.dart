import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  String _editText = "";
  List<String> _todos = [];

  void addTodoItem() {
    _todos = [..._todos, _editText];

    // テキストフォームをクリア
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ToDo"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                onChanged: (String? value) {
                  _editText = value!;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => addTodoItem(),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(child: ListTile(title: Text(_todos[index])));
              },
            )
          ],
        ));
  }
}
