import 'package:rxdart/rxdart.dart';
import 'package:date_format/date_format.dart';
import 'package:todo/db/todo/model.dart';
import 'package:todo/db/todo/service.dart';

import 'package:todo/shared/data.dart' show today;

class TodoStore {
  BehaviorSubject<DateTime> _day = BehaviorSubject.seeded(today);
  BehaviorSubject<List<TodoModel>> _todos = BehaviorSubject.seeded(List());

  Observable get stream$ => _day.stream;
  Observable<List<TodoModel>> get todosStream$ => _todos.stream;

  DateTime get current => _day.value;
  List<TodoModel> get todos => _todos.value;

  String get formattedDay =>
      current == today ? 'Today' : formatDate(current, [DD, ', ', d]);

  setDay(DateTime newDay) {
    if (newDay != current) {
      _day.add(newDay);
    }
  }

  Future fetchTodos() async {
    TodoService service = TodoService.instance;
    List<TodoModel> res = await service.list(current);
    _todos.add(res);
  }
}
