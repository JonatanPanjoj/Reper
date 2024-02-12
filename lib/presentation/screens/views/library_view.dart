import 'package:flutter/material.dart';
import 'package:reper/config/theme/app_font_styles.dart';

import 'package:reper/presentation/widgets/widgets.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Canciones'),
          bottom: const TabBar(
            dividerHeight: 0,
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text: 'Mis Canciones'),
              Tab(text: 'Mis Listas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMySongsTab(),
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMySongsTab() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () {
                
              },
              child: const Row(
                children: [
                  Icon(Icons.add, size: 50,),
                  SizedBox(width: 20),
                  Text('Agregar una canción', style: normal20,)
                ],
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return const CardTypeThree(
              title: 'Hola',
              subtitle: 'Como estas',
            );
          },
        )
      ],
    );
  }
}
