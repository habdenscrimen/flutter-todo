import 'package:flutter/material.dart';

import 'screens/home/main.dart' show Home;
import 'screens/settings.dart' show Settings;
import 'screens/add_todo.dart' show AddTodo;

import 'stores/main.dart' show setupLocator;

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/settings': (context) => Settings(),
        '/add_todo': (context) => AddTodo(),
      },
      title: 'Todo',
    );
  }
}
