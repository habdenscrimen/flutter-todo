import 'package:get_it/get_it.dart';

import 'day.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton<DayStore>(DayStore());
}
