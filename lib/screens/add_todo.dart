import 'package:flutter/material.dart';
import 'package:todo/bloc/locator.dart';
import 'package:todo/bloc/todo.dart';

import 'package:todo/model/todo.dart';
import 'package:todo/shared/data.dart';

class AddTodo extends StatelessWidget {
  final TodoBloc bloc = locator<TodoBloc>();

  final TodoModel _mockTodo = TodoModel(
    done: false,
    title: 'New todo',
    startDate: today,
    endDate: today,
  );

  Future<void> _addTodo(TodoModel todo) async {
    await bloc.addTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RaisedButton(
        child: Text('Add todo'),
        onPressed: () => _addTodo(_mockTodo),
      ),
    );
  }
}
