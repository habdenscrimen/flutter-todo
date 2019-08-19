import 'package:rxdart/rxdart.dart';

import 'package:todo/shared/data.dart' show today;

class DayStore {
  // Day to fetch todos.
  BehaviorSubject<DateTime> _day = BehaviorSubject.seeded(today);

  Observable get stream$ => _day.stream;
  DateTime get current => _day.value;

  setDay(DateTime newDay) {
    if (newDay != current) {
      _day.add(newDay);
    }
  }
}
