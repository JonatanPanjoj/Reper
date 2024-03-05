import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/songs_repository_provider.dart';
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
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
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
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.push('/edit-song-screen', extra: data);
                      },
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
        scrollController: scrollController,
        speed: pixelsPerSecond,
      ),
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
