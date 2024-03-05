import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumsView extends ConsumerStatefulWidget {
  const AlbumsView({super.key});

  @override
  AlbumsViewState createState() => AlbumsViewState();
}

class AlbumsViewState extends ConsumerState<AlbumsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Canciones públicas'),
          ),
          SliverList.builder(

            itemBuilder: (context, index) {

            },
          )
        ],
      ),
    );
  }
}
