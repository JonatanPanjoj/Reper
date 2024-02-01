import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/presentation/providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Cambiar Tema'),
          onPressed: () {
            ref.read(themeNotifierProvider.notifier).toggleDarkMode();
          },
        ),
      ),
    );
  }
}
