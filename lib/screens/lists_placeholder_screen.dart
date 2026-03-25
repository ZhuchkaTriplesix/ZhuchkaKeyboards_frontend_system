import 'package:flutter/material.dart';

/// Placeholder until table views and filters (issue #7).
class ListsPlaceholderScreen extends StatelessWidget {
  const ListsPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Lists and filters — placeholder (issue #7).',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
