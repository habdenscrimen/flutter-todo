import 'package:flutter/material.dart';

import 'package:todo/bloc/all.dart' show locator, TodoBloc;
import 'package:todo/model/todo.dart' show TodoModel;
import 'package:todo/shared/data.dart' show today;

class AddTodo extends StatelessWidget {
  final TodoBloc bloc = locator<TodoBloc>();

  Future<void> _addTodo(TodoModel todo) async {
    await bloc.addTodo(todo);
    await bloc.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: bloc.selectedDay.stream,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text('Add todo'),
            onPressed: () => _addTodo(
              TodoModel(
                done: false,
                title: 'New todo',
                day: snapshot.data,
                startTime: today,
                endTime: today,
              ),
            ),
          );
        },
      ),
    );
  }
}
