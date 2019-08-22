import 'package:flutter/material.dart';

import 'package:todo/bloc/all.dart' show locator, TodoBloc;
import 'package:todo/model/todo.dart' show TodoModel;
import 'package:todo/shared/data.dart' show today;

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TodoBloc bloc = locator<TodoBloc>();
  String _title = '';
  bool _validateError = false;
  DateTime _startTime = today;
  DateTime _endTime = today;

  Future<void> _addTodo(TodoModel todo) async {
    await bloc.addTodo(todo);
    await bloc.fetchTodos();

    setState(() {
      _validateError = false;
      _title = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Task name',
              hintText: 'My new todo',
              errorText: _validateError ? 'Name can\'t be empty' : null,
            ),
            onChanged: (String value) {
              setState(() {
                _title = value;
              });
            },
          ),
          Text('TODO: Set start time'),
          Text('TODO: Set end time'),
          StreamBuilder(
            stream: bloc.selectedDay.stream,
            builder: (context, snapshot) {
              return RaisedButton(
                child: Text('Add todo'),
                onPressed: () async {
                  if (_title == '' || _title.isEmpty) {
                    setState(() {
                      _validateError = true;
                    });
                  } else {
                    await _addTodo(
                      TodoModel(
                        done: false,
                        title: _title,
                        day: snapshot.data,
                        startTime: _startTime,
                        endTime: _endTime,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
