import 'package:flutter/material.dart';

import 'calendar.dart' show Calendar;
import 'timeline.dart' show Timeline;

import 'package:todo/stores/main.dart' show TodoStore, locator;
import 'package:todo/shared/data.dart' show today;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoStore _dayStore = locator<TodoStore>();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          initialData: today,
          stream: _dayStore.stream$,
          builder: (context, snap) {
            return Text('${_dayStore.formattedDay}');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Calendar(),
            ),
            Timeline(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_todo');
        },
      ),
    );
  }
}
