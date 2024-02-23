import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/domain/entities/section.dart';
import 'package:reper/presentation/widgets/components/shared/custom_sliver_app_bar.dart';

class SectionScreen extends StatefulWidget {
  final String image;
  final Section section;

  const SectionScreen({super.key, required this.section, required this.image});

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  int transposeIncrement = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: widget.section.name,
            subtitle: widget.section.song.title,
            height: size.height * 0.2,
            image: widget.image,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildToneController(),
                _buildLyrics(size, colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToneController() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      transposeIncrement--;
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove)),
                const Text(
                  'Tono',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      transposeIncrement++;
                      setState(() {});
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
          ),
        ],
      ),
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
            lyrics: widget.section.song.lyrics,
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
