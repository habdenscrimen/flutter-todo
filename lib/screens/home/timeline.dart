import 'package:flutter/material.dart';
import 'package:todo/bloc/locator.dart';
import 'package:todo/bloc/todo.dart';
import 'package:todo/model/todo.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final TodoBloc bloc = locator<TodoBloc>();

  @override
  void initState() {
    super.initState();
    bloc.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TodoModel>>(
      initialData: [],
      stream: bloc.todos.stream,
      builder: (context, snapshot) {
        return Column(
          children: snapshot.data.map((todo) => Text(todo.title)).toList(),
        );
      },
    );
  }
}
