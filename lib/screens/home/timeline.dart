import 'package:flutter/material.dart';

import 'package:todo/db/todo/model.dart';
import 'package:todo/stores/main.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final TodoStore _dayStore = locator<TodoStore>();

  @override
  void initState() {
    super.initState();
    _dayStore.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TodoModel>>(
      initialData: [],
      stream: _dayStore.todosStream$,
      builder: (context, snapshot) {
        return Column(
          children: snapshot.data.map((todo) => Text(todo.title)).toList(),
        );
      },
    );
  }
}
