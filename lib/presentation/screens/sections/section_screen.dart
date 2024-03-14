import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/presentation/widgets/widgets.dart';

import '../../../domain/entities/entities.dart';

class SectionScreen extends StatefulWidget {
  final String image;
  final Section section;
  final Song song;

  const SectionScreen({
    super.key,
    required this.section,
    required this.image,
    required this.song,
  });

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  ScrollController scrollController = ScrollController();

  int transposeIncrement = 0;
  int speed = 10;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          CustomSliverAppBar(
            title: widget.section.name,
            subtitle: widget.song.title,
            height: size.height * 0.2,
            image: widget.image,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ToneButtons(
                  speed: speed,
                  onDecrement: () {
                    transposeIncrement--;
                    setState(() {});
                  },
                  onIncrement: () {
                    transposeIncrement++;
                    setState(() {});
                  },
                  onDecrementSpeed: () {
                    if (speed > 10) {
                      speed -= 10;
                      setState(() {});
                    }
                  },
                  onIncrementSpeed: () {
                    speed += 10;
                    setState(() {});
                  },
                ),
                _buildLyrics(size, colors),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingSpeedButtons(
        onDecrement: _onDecrement,
        onPause: _onPause,
        onIncrement: _onIncrement,
      ),
    );
  }

  void _onPause() {
    scrollController.jumpTo(scrollController.position.pixels);
  }

  void _onIncrement() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(
        seconds: ((scrollController.position.maxScrollExtent -
                    scrollController.position.pixels) /
                speed)
            .round(),
      ),
      curve: Curves.linear,
    );
  }

  void _onDecrement() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(
        seconds: ((scrollController.position.pixels -
                    scrollController.position.minScrollExtent) /
                speed)
            .round(),
      ),
      curve: Curves.linear,
    );
  }

  Widget _buildLyrics(Size size, ThemeData colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          LyricsRenderer(
            horizontalAlignment: CrossAxisAlignment.start,
            widgetPadding: (size.width * 0.3).round(),
            lyrics: widget.song.lyrics,
            textStyle: normal16.copyWith(color: colors.colorScheme.onSurface),
            chordStyle: bold16.copyWith(color: colors.colorScheme.primary),
            transposeIncrement: transposeIncrement,
            scrollSpeed: 20,
            onTapChord: () {},
          ),
        ],
      ),
    );
  }
}
