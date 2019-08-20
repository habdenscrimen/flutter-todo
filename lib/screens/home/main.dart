import 'package:flutter/material.dart';

import 'calendar.dart' show Calendar;
import 'timeline.dart' show Timeline;

import 'package:todo/store/main.dart' show DayStore, locator;
import 'package:date_format/date_format.dart';
import 'package:todo/shared/data.dart' show today;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DayStore _dayStore = locator<DayStore>();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          initialData: today,
          stream: _dayStore.stream$,
          builder: (context, snap) {
            return Text('${formatDate(snap.data, [DD, ', ', d])}');
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
