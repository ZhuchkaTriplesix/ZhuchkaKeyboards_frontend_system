import 'package:flutter_test/flutter_test.dart';

import 'package:zhuchka_system/main.dart';

void main() {
  testWidgets('NavigationRail opens lists placeholder', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Dashboard'), findsWidgets);

    await tester.tap(find.text('Lists'));
    await tester.pumpAndSettle();

    expect(find.text('Lists'), findsWidgets);
    expect(
      find.textContaining('Lists and filters'),
      findsOneWidget,
    );
  });

  testWidgets('NavigationRail opens settings placeholder', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsWidgets);
    expect(find.textContaining('Settings — placeholder'), findsOneWidget);
  });

  testWidgets('returns to dashboard from lists', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lists'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dashboard'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Staff console'), findsOneWidget);
  });
}
