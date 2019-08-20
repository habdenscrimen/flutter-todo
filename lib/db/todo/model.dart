// Database table and column names.
final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class TodoModel {
  int id;
  String title;
  bool done;

  TodoModel({this.id, this.title, this.done});

  Map<String, dynamic> toMap() => {
        columnTitle: title,
        columnDone: done == true ? 1 : 0,
      };

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
        id: map[columnId],
        title: map[columnTitle],
        done: map[columnDone] == 1,
      );
}
