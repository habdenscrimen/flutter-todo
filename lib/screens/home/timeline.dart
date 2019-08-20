import 'package:flutter/material.dart';

import 'package:todo/stores/main.dart' show DayStore, locator;
import 'package:todo/shared/data.dart' show today;

class Timeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DayStore _dayStore = locator<DayStore>();

    return StreamBuilder(
      initialData: today,
      stream: _dayStore.stream$,
      builder: (context, snap) {
        return Text('Selected day: ${_dayStore.formattedDay}');
      },
    );
  }
}
