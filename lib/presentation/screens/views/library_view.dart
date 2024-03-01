import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/app_font_styles.dart';
import 'package:reper/domain/entities/song.dart';
import 'package:reper/presentation/providers/providers.dart';

import 'package:reper/presentation/widgets/widgets.dart';

class LibraryView extends ConsumerWidget {
  final bool isaddSongScreen;

  const LibraryView({super.key, this.isaddSongScreen = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 0,
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
            _buildMySongsTab(ref, context),
            const Center(
              child: Text("Proximamente..."),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMySongsTab(WidgetRef ref, BuildContext context) {
    final List<Song> userSongs = ref.watch(userSongsListProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () {
                context.push('/create-song');
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Agregar una canción',
                    style: normal20,
                  )
                ],
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemCount: userSongs.length,
          itemBuilder: (context, index) {
            return CardTypeThree(
              title: userSongs[index].title,
              subtitle: userSongs[index].artist,
              onTap: () {
                if (!isaddSongScreen) {
                  context.push('/song-screen', extra: userSongs[index]);
                } else {
                  context.pop(userSongs[index]);
                }
              },
              deleteDialogWidget: const DeleteSectionDialog(),
              onDelete: () async {
                
              },
            );
          },
        )
      ],
    );
  }
}
