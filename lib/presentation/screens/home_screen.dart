import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/presentation/providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Hola como estas?'),
              ),
            ),
            TextButton(
              child: const Text('Cambiar Tema'),
              onPressed: () {
                ref.read(themeNotifierProvider.notifier).toggleDarkMode();
              },
            ),
          ],
        ),
      ),
    );
  }
}
