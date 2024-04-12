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
              Tab(text: 'Favoritos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMySongsTab(ref, context),
            _buildMyFavoriteSongsTab(ref, context)
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
              onDelete: () async {},
            );
          },
        )
      ],
    );
  }

  Widget _buildMyFavoriteSongsTab(WidgetRef ref, BuildContext context) {
    final List<String> userSongs = ref.watch(userProvider).favorites!;
    return userSongs.isNotEmpty
        ? StreamBuilder(
            stream: ref
                .watch(songsRepositoryProvider)
                .streamFavoriteSongs(songs: userSongs),
            builder: (context, snapshot) {
              final songs = snapshot.data;
              if (songs == null) {
                return const Center(child: CustomLoading());
              }

              if (songs.isEmpty) {
                return const Center(
                    child: Text('Aún no tienes canciones favoritas'));
              }

              return CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return CardTypeThree(
                        title: songs[index].title,
                        subtitle: songs[index].artist,
                        onTap: () {
                          if (!isaddSongScreen) {
                            context.push('/song-screen', extra: songs[index]);
                          } else {
                            context.pop(songs[index]);
                          }
                        },
                        onDelete: () async {},
                      );
                    },
                  )
                ],
              );
            })
        : _buildNoFavorites(context);
  }

  Widget _buildNoFavorites(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline_sharp,
            size: 60,
            color: colors.primary,
          ),
          Text(
            'Ohh no!!!',
            style: TextStyle(fontSize: 30, color: colors.primary),
          ),
          const Text(
            'No tienes canciones favoritas',
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
