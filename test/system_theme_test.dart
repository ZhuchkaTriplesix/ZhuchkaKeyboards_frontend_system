import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zhuchka_system/theme/system_theme.dart';

void main() {
  group('buildZhuchkaSystemTheme', () {
    test('uses Material 3 and dark brightness', () {
      final theme = buildZhuchkaSystemTheme();
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('scaffold background is OLED black per frontend-requirements', () {
      final theme = buildZhuchkaSystemTheme();
      expect(theme.scaffoldBackgroundColor, const Color(0xFF000000));
      final tokens = theme.extension<ZhuchkaSystemTokens>();
      expect(tokens, isNotNull);
      expect(tokens!.oledBlack, const Color(0xFF000000));
    });

    testWidgets('ThemeData drives scaffold background for Scaffold', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: buildZhuchkaSystemTheme(),
          home: Builder(
            builder: (context) {
              expect(
                Theme.of(context).scaffoldBackgroundColor,
                const Color(0xFF000000),
              );
              return const Scaffold(body: SizedBox.shrink());
            },
          ),
        ),
      );
    });
  });
}
