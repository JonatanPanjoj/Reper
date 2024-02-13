import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/domain/entities/entities.dart';

class SongScreen extends StatelessWidget {
  final Song song;

  const SongScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Lyrics'),
            titleSpacing: 10,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.edit),
              ),
            ],
          ),
          _buildBody(size, colors)
        ],
      ),
    );
  }

  SliverList _buildBody(Size size, ColorScheme colors) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/disco-de-vinilo.png',
                height: size.width * 0.2,
                width: size.width * 0.2,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: bold20,
                  ),
                  Text(song.artist),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LyricsRenderer(
            horizontalAlignment: CrossAxisAlignment.start,
            widgetPadding: 50,
            lyrics: song.lyrics,
            textStyle: normal16.copyWith(color: colors.onSurface),
            chordStyle: bold16.copyWith(color: colors.primary),
            onTapChord: () {},
          ),
        )
      ]),
    );
  }
}
