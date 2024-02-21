import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/songs_repository_provider.dart';
import 'package:reper/presentation/widgets/elements/custom_loading.dart';

class SongScreen extends ConsumerStatefulWidget {
  final Song song;

  const SongScreen({super.key, required this.song});

  @override
  SongScreenState createState() => SongScreenState();
}

class SongScreenState extends ConsumerState<SongScreen> {
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
    );
  }

  SliverList _buildBody(Size size, ColorScheme colors, Song song) {
    return SliverList(
      delegate: SliverChildListDelegate([
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:15, vertical: 10),
              child: LyricsRenderer(
                horizontalAlignment: CrossAxisAlignment.start,
                widgetPadding: (size.width * 0.3).round(),
                lyrics: song.lyrics,
                textStyle: normal16.copyWith(color: colors.onSurface),
                chordStyle: bold16.copyWith(color: colors.primary),
                onTapChord: () {},
              ),
            ),
          ),
        )
      ]),
    );
  }
}
