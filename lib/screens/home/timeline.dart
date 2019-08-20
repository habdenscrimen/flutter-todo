import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import 'package:todo/store/main.dart' show DayStore, locator;
import 'package:todo/shared/data.dart' show today;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    final DayStore _dayStore = locator<DayStore>();

    return StreamBuilder(
      initialData: today,
      stream: _dayStore.stream$,
      builder: (context, snap) {
        return Text('Selected day: ${formatDate(snap.data, [DD, ', ', d])}');
      },
    );
  }
}
