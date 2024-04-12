import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/songs_repository_provider.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class SongScreen extends ConsumerStatefulWidget {
  final Song song;

  const SongScreen({super.key, required this.song});

  @override
  SongScreenState createState() => SongScreenState();
}

class SongScreenState extends ConsumerState<SongScreen> {
  int transposeIncrement = 0;
  int pixelsPerSecond = 10;

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final AppUser user = ref.watch(userProvider);
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final existInFavorites = user.favorites!.contains(widget.song.id);

    return Scaffold(
      body: StreamBuilder(
        stream: ref
            .watch(songsRepositoryProvider)
            .streamSong(songId: widget.song.id),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: CustomLoading());
          }
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                title: const Text('Lyrics'),
                titleSpacing: 10,
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        widget.song.createdBy == user.uid
                            ? IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  context.push('/edit-song-screen',
                                      extra: data);
                                },
                              )
                            : const SizedBox(),
                        IconButton(
                          icon: existInFavorites
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border),
                          onPressed: () async {
                            ref.read(userRepositoryProvider).updateFavorites(
                                  songId: widget.song.id,
                                  uid: user.uid,
                                  isAdd: !existInFavorites,
                                );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              _buildBody(size, colors, data)
            ],
          );
        },
      ),
      floatingActionButton: FloatingSpeedButtons(
        onDecrement: _onDecrement,
        onPause: _onPause,
        onIncrement: _onIncrement,
      ),
    );
  }

  void _onIncrement() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(
        seconds: ((scrollController.position.maxScrollExtent -
                    scrollController.position.pixels) /
                pixelsPerSecond)
            .round(),
      ),
      curve: Curves.linear,
    );
  }

  void _onPause() {
    scrollController.jumpTo(scrollController.position.pixels);
  }

  void _onDecrement() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(
        seconds: ((scrollController.position.pixels -
                    scrollController.position.minScrollExtent) /
                pixelsPerSecond)
            .round(),
      ),
      curve: Curves.linear,
    );
  }

  SliverList _buildBody(Size size, ColorScheme colors, Song song) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: bold20,
                ),
                Text(song.artist),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ToneButtons(
            speed: pixelsPerSecond,
            onDecrement: () {
              transposeIncrement--;
              setState(() {});
            },
            onIncrement: () {
              transposeIncrement++;
              setState(() {});
            },
            onDecrementSpeed: () {
              if (pixelsPerSecond > 10) {
                pixelsPerSecond -= 10;
              }
              setState(() {});
            },
            onIncrementSpeed: () {
              pixelsPerSecond += 10;
              setState(() {});
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: LyricsRenderer(
                  transposeIncrement: transposeIncrement,
                  horizontalAlignment: CrossAxisAlignment.start,
                  widgetPadding: (size.width * 0.3).round(),
                  lyrics: song.lyrics,
                  textStyle: normal16.copyWith(color: colors.onSurface),
                  chordStyle: bold16.copyWith(color: colors.primary),
                  onTapChord: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
