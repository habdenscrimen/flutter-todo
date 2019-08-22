import 'package:meta/meta.dart';

// Database table and column names.
final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';
final String columnDay = 'day';
final String columnStartTime = 'start_date';
final String columnEndTime = 'end_date';

class TodoModel {
  int id;
  String title;
  bool done;
  DateTime day;
  DateTime startTime;
  DateTime endTime;

  TodoModel({
    this.id,
    @required this.title,
    @required this.done,
    @required this.startTime,
    @required this.endTime,
    @required this.day,
  });

  Map<String, dynamic> toMap() => {
        columnTitle: title,
        columnDone: done == true ? 1 : 0,
        columnStartTime: startTime.toIso8601String(),
        columnEndTime: endTime.toIso8601String(),
        columnDay: day.toIso8601String(),
      };

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
        id: map[columnId],
        title: map[columnTitle],
        done: map[columnDone] == 1,
        day: DateTime.parse(map[columnDay]),
        startTime: DateTime.parse(map[columnStartTime]),
        endTime: DateTime.parse(map[columnEndTime]),
      );
}
