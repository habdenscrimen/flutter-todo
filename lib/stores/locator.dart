import 'package:get_it/get_it.dart';

import 'todo.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton<TodoStore>(TodoStore());
}
