import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app/system_router.dart';
import 'theme/system_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router = createSystemRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Zhuchka System',
      theme: buildZhuchkaSystemTheme(),
      themeMode: ThemeMode.dark,
      routerConfig: _router,
    );
  }
}
