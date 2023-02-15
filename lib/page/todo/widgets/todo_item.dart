import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/Todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final void Function(int) onDeleteTodo;
  final void Function(int) onChangeIsDone;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onDeleteTodo,
    required this.onChangeIsDone,
  });

  @override
  Widget build(BuildContext context) {
    const Color tdRed = Color(0xFFDA4040);

    return Container(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.grey[100],
        title: Text(
          todo.name,
          style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        leading: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Checkbox(
              value: todo.isDone,
              onChanged: (bool? value) {
                onChangeIsDone(todo.id);
              },
            )),
        trailing: Container(
          padding: const EdgeInsets.all(0), // TODO padding 0 なら定義する必要なくない？
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteTodo(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
