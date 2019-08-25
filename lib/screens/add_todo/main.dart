import 'package:flutter/material.dart';

import 'package:todo/bloc/all.dart' show locator, TodoBloc;
import 'package:todo/model/todo.dart' show TodoModel;
import 'package:todo/shared/all.dart' show ThemeColors;
import 'input_dropdown.dart';

enum Times { start, end }

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> with ThemeColors {
  final TodoBloc bloc = locator<TodoBloc>();
  String _title = '';
  bool _validateError = false;
  final TextEditingController _titleController = new TextEditingController();

  static final TimeOfDay _nowTime = TimeOfDay.now();

  final Map<Times, TimeOfDay> _times = {
    Times.start: _nowTime,
    Times.end: TimeOfDay(hour: _nowTime.hour + 2, minute: _nowTime.minute),
  };

  Future<void> _addTodo(BuildContext context, TodoModel newTodo) async {
    // Form validation
    if (_title == '' || _title.isEmpty) {
      setState(() {
        _validateError = true;
      });
    } else {
      await bloc.addTodo(newTodo);
      await bloc.fetchTodos();

      // Reset form values.
      setState(() {
        _validateError = false;
        _title = '';
      });
      _titleController.clear();
    }
  }

  // Select time with time picker.
  _selectTime(BuildContext context, Times type) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _times[type],
    );

    if (picked != null && picked != _times[type]) {
      setState(() {
        _times[type] = picked;
      });
    }
  }

  void _changeTitle(String newText) {
    setState(() {
      _title = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Task name',
              hintText: 'My new todo',
              errorText: _validateError ? 'Name can\'t be empty' : null,
            ),
            onChanged: _changeTitle,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const SizedBox(width: 12.0),
              Expanded(
                flex: 3,
                child: InputDropdown(
                  valueText: _times[Times.start].format(context),
                  valueStyle: valueStyle,
                  onPressed: () {
                    _selectTime(context, Times.start);
                  },
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                flex: 3,
                child: InputDropdown(
                  valueText: _times[Times.end].format(context),
                  valueStyle: valueStyle,
                  onPressed: () {
                    _selectTime(context, Times.end);
                  },
                ),
              ),
            ],
          ),
          StreamBuilder(
            stream: bloc.selectedDay.stream,
            builder: (context, snapshot) {
              return RaisedButton(
                child: Text('Add todo'),
                onPressed: () async {
                  await _addTodo(
                    context,
                    TodoModel(
                      done: false,
                      title: _title,
                      day: snapshot.data,
                      endTime: bloc.getDateWithTime(_times[Times.end]),
                      startTime: bloc.getDateWithTime(_times[Times.start]),
                    ),
                  );
                  if (!_validateError)
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Todo added'),
                      // backgroundColor: red,
                    ));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
