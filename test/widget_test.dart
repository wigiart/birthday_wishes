import 'package:flutter_test/flutter_test.dart';

import 'package:birthday_wishes/main.dart';

void main() {
  testWidgets('Birthday Wishes app test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BirthdayWishesApp());

    // Verify that the app starts with the default relation.
    expect(find.text('Friend'), findsOneWidget);
  });
}
