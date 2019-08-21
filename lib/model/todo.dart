import 'package:meta/meta.dart';

// Database table and column names.
final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';
final String columnStartDate = 'start_date';
final String columnEndDate = 'end_date';

class TodoModel {
  int id;
  String title;
  bool done;
  DateTime startDate;
  DateTime endDate;

  TodoModel({
    this.id,
    @required this.title,
    @required this.done,
    @required this.startDate,
    @required this.endDate,
  });

  Map<String, dynamic> toMap() => {
        columnTitle: title,
        columnDone: done == true ? 1 : 0,
        columnStartDate: startDate.toIso8601String(),
        columnEndDate: endDate.toIso8601String(),
      };

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
        id: map[columnId],
        title: map[columnTitle],
        done: map[columnDone] == 1,
        startDate: DateTime.parse(map[columnStartDate]),
        endDate: DateTime.parse(map[columnEndDate]),
      );
}
