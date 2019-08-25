import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:todo/bloc/all.dart' show locator, TodoBloc;
import 'package:todo/shared/all.dart' show today, ThemeColors;
import 'calendar.dart' show Calendar;
import 'timeline.dart' show Timeline;

class Home extends StatefulWidget with ThemeColors {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isAddButtonVisible = true;
  ScrollController _hideAddButtonController = ScrollController();

  @override
  void initState() {
    super.initState();
    _hideAddButtonController.addListener(() {
      if (_hideAddButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isAddButtonVisible == true) {
          setState(() {
            _isAddButtonVisible = false;
          });
        }
      } else {
        if (_hideAddButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isAddButtonVisible == false) {
            setState(() {
              _isAddButtonVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _hideAddButtonController.dispose();
    super.dispose();
  }

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
        controller: _hideAddButtonController,
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
      floatingActionButton: AnimatedOpacity(
        opacity: _isAddButtonVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            if (_isAddButtonVisible) {
              Navigator.pushNamed(context, '/add_todo');
            }
          },
        ),
      ),
    );
  }
}
