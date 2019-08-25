import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:todo/bloc/all.dart' show locator, TodoBloc;
import 'package:todo/model/todo.dart' show TodoModel;
import 'package:todo/shared/all.dart' show ThemeColors;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> with ThemeColors {
  final TodoBloc bloc = locator<TodoBloc>();

  @override
  void initState() {
    super.initState();
    bloc.fetchTodos();
  }

  String _getTime(DateTime date) =>
      '${formatDate(date, [hh, ':', nn, ' ', am])}';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TodoModel>>(
      initialData: [],
      stream: bloc.todos.stream,
      builder: (context, snapshot) {
        return Column(
          children: snapshot.data.map((todo) => _buildTodoItem(todo)).toList(),
        );
      },
    );
  }

  // Item of todo list.
  Dismissible _buildTodoItem(TodoModel todo) {
    return Dismissible(
      key: Key(todo.id.toString()),
      onDismissed: (direction) {
        bloc.delete(todo);
      },
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: todo.done,
                  onChanged: (bool newValue) async {
                    await bloc.update(TodoModel(
                      done: newValue,
                      id: todo.id,
                      day: todo.day,
                      endTime: todo.endTime,
                      startTime: todo.startTime,
                      title: todo.title,
                    ));
                    await bloc.fetchTodos();
                  },
                ),
                Text(todo.title),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                '${_getTime(todo.startTime)} - ${_getTime(todo.endTime)}',
              ),
            )
          ],
        ),
      ),
    );
  }
}
