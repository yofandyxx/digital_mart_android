import 'package:flutter_test/flutter_test.dart';

import 'package:digitalmart/main.dart';

void main() {
  testWidgets('Digital Mart home screen shows products', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DigitalMartApp());

    expect(find.text('Digital Mart'), findsOneWidget);
    expect(find.text('Laptop Pro 14'), findsOneWidget);
    expect(find.text('Smartphone X'), findsOneWidget);
  });
}
