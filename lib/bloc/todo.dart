import 'package:date_format/date_format.dart';
import 'package:rxdart/rxdart.dart';

import 'package:todo/model/todo.dart' show TodoModel;
import 'package:todo/repository/todo.dart' show TodoRepository;
import 'package:todo/shared/data.dart' show today;

class TodoBloc {
  final TodoRepository _repository = TodoRepository();

  final BehaviorSubject<DateTime> _selectedDay =
      BehaviorSubject<DateTime>.seeded(today);
  final BehaviorSubject<List<TodoModel>> _todos =
      BehaviorSubject<List<TodoModel>>();

  BehaviorSubject<DateTime> get selectedDay => _selectedDay;
  BehaviorSubject<List<TodoModel>> get todos => _todos;

  String get formattedDay => _selectedDay.value == today
      ? 'Today'
      : formatDate(_selectedDay.value, [DD, ', ', d]);

  dispose() {
    _todos.close();
    _selectedDay.close();
  }

  selectDay(DateTime newDay) {
    if (_selectedDay.value != newDay) {
      _selectedDay.sink.add(newDay);
    }
  }

  Future<void> fetchTodos() async {
    List<TodoModel> response = await _repository.list(_selectedDay.value);
    _todos.sink.add(response);
  }

  Future<void> addTodo(TodoModel todo) async {
    _repository.addTodo(todo);
  }

  Future<void> update(TodoModel todo) async {
    _repository.update(todo);
  }
}
