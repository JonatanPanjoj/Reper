import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/presentation/providers/providers.dart';

class AlbumsView extends ConsumerStatefulWidget {
  const AlbumsView({super.key});

  @override
  AlbumsViewState createState() => AlbumsViewState();
}

class AlbumsViewState extends ConsumerState<AlbumsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            ref.read(authProvider).signOut();
            context.replace('/home/0');
          },
          child: const Text('sign out'),
        ),
      ),
    );
  }
}
