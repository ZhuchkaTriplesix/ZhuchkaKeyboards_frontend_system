import 'package:flutter_test/flutter_test.dart';

import 'package:zhuchka_system/main.dart';

void main() {
  testWidgets('dashboard shows baseline copy', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Dashboard'), findsWidgets);
    expect(find.textContaining('Staff console'), findsOneWidget);
  });
}
