import 'package:flutter_test/flutter_test.dart';

import 'package:todo/screens/settings.dart';
import 'utils.dart';

void main() {
  testWidgets("Settings screen has a text 'settings'",
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestable(child: Settings()));

    expect(find.text('settings'), findsOneWidget);
  });
}
