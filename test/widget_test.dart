import 'package:flutter_test/flutter_test.dart';

import 'package:zhuchka_system/main.dart';

void main() {
  testWidgets('home shows app title and baseline copy', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Zhuchka System'), findsOneWidget);
    expect(find.textContaining('Staff console'), findsOneWidget);
  });
}
