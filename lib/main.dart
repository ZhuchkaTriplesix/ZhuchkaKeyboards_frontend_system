import 'package:flutter/material.dart';

import 'theme/system_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zhuchka System',
      theme: buildZhuchkaSystemTheme(),
      themeMode: ThemeMode.dark,
      home: const SystemHomePage(),
    );
  }
}

/// Bootstrap home until routing and shell land (issue #2).
class SystemHomePage extends StatelessWidget {
  const SystemHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zhuchka System'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Staff console — M3 theme baseline (OLED #000000 scaffold). '
            'See docs/frontend-requirements.md in the monorepo.',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
