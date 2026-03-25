import 'package:go_router/go_router.dart';

import '../screens/dashboard_screen.dart';
import '../screens/lists_placeholder_screen.dart';
import '../screens/settings_placeholder_screen.dart';
import '../widgets/system_shell.dart';

/// Staff console routes: dashboard and placeholders behind [SystemShell].
GoRouter createSystemRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return SystemShell(
            location: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/lists',
            builder: (context, state) => const ListsPlaceholderScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPlaceholderScreen(),
          ),
        ],
      ),
    ],
  );
}
