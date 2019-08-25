import 'package:todo/model/todo.dart';

import 'todo_provider.dart' show TodoProvider;

class TodoRepository {
  TodoProvider _todoProvider = TodoProvider.instance;

  Future<List<TodoModel>> list(DateTime date) {
    return _todoProvider.list(date);
  }

  Future<void> addTodo(TodoModel todo) async {
    await _todoProvider.add(todo);
  }

  Future<void> update(TodoModel todo) async {
    await _todoProvider.update(todo);
  }

  Future<void> delete(TodoModel todo) async {
    await _todoProvider.delete(todo);
  }
}
