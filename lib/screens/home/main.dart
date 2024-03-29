import 'package:flutter/material.dart';

import 'package:todo/bloc/all.dart' show locator, TodoBloc;
import 'package:todo/shared/data.dart' show today;
import 'calendar.dart' show Calendar;
import 'timeline.dart' show Timeline;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoBloc bloc = locator<TodoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          initialData: today,
          stream: bloc.selectedDay.stream,
          builder: (context, snap) {
            return Text('${bloc.formattedDay}');
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
