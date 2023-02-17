class Todo {
  int id;
  String name;
  bool isDone;

  Todo({
    required this.id,
    required this.name,
    this.isDone = false,
  });
}
