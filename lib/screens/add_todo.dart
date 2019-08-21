import 'package:flutter/material.dart';

import 'package:todo/db/todo/model.dart';
import 'package:todo/db/todo/service.dart';
import 'package:todo/shared/data.dart';

class AddTodo extends StatelessWidget {
  Future<void> _addTodo() async {
    TodoService service = TodoService.instance;
    TodoModel todo = TodoModel(
      done: false,
      title: 'New todo',
      startDate: today,
      endDate: today,
    );
    await service.add(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RaisedButton(
        child: Text('Add todo'),
        onPressed: _addTodo,
      ),
    );
  }
}
