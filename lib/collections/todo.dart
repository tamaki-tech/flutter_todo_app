import 'package:isar/isar.dart';

part "todo.g.dart";

@Collection()
class Todo {
  Todo({this.isDone = false});

  /// ID
  Id id = Isar.autoIncrement;

  /// 名称
  late String name;

  /// 完了したか否か
  late bool isDone;
}
