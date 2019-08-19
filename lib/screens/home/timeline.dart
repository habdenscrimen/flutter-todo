import 'package:flutter/material.dart';

import 'package:todo/store/main.dart' show DayStore, locator;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    final DayStore dayStore = locator.get<DayStore>();

    return StreamBuilder(
      stream: dayStore.stream$,
      builder: (context, snap) {
        return Text('Selected day: ${snap.data}');
      },
    );
  }
}
