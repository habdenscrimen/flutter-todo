import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, WeekdayFormat;
import 'package:flutter_calendar_carousel/classes/event.dart' show Event;
import 'package:todo/bloc/locator.dart';
import 'package:todo/bloc/todo.dart';

import 'package:todo/shared/main.dart' show today, ThemeColors;

class Calendar extends StatelessWidget with ThemeColors {
  @override
  Widget build(BuildContext context) {
    final TodoBloc bloc = locator<TodoBloc>();

    return StreamBuilder(
      stream: bloc.selectedDay.stream,
      builder: (context, snap) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              bloc.selectDay(date);
              bloc.fetchTodos();
            },
            thisMonthDayBorderColor: Colors.transparent,
            selectedDayButtonColor: Colors.transparent,
            selectedDayBorderColor: red,
            todayButtonColor: red,
            todayBorderColor: Colors.transparent,
            selectedDayTextStyle: TextStyle(color: lightBlack),
            weekendTextStyle: TextStyle(color: dark),
            daysTextStyle: TextStyle(color: lightBlack),

            nextDaysTextStyle: TextStyle(color: lightDark),
            prevDaysTextStyle: TextStyle(color: lightDark),
            weekdayTextStyle: TextStyle(color: dark),
            weekDayFormat: WeekdayFormat.narrow,
            firstDayOfWeek: 1,
            showHeader: true,
            isScrollable: false,
            weekFormat: false,
            height: 350.0,
            // height: 280.0,
            selectedDateTime: snap.data == today ? null : snap.data,
            daysHaveCircularBorder: true,
            customGridViewPhysics: NeverScrollableScrollPhysics(),
            // markedDatesMap: _getCarouselMarkedDates(),
            // markedDateWidget: Container(
            //   height: 3,
            //   width: 3,
            //   decoration: BoxDecoration(
            //     color: Color(0xFF30A9B2),
            //     shape: BoxShape.rectangle,
            //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
            //   ),
            // ),
          ),
        );
      },
    );
  }

  // EventList<Event> _getCarouselMarkedDates() {
  //   return EventList<Event>(
  //     events: {
  //       DateTime(2019, 8, 3): [
  //         Event(
  //           date: DateTime(2019, 8, 3, 17, 30),
  //           title: 'Event 1',
  //         ),
  //       ],
  //     },
  //   );
  // }
}
