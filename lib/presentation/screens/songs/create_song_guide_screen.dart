import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/presentation/widgets/elements/custom_input.dart';

class CreateSongGuideScreen extends StatefulWidget {
  const CreateSongGuideScreen({super.key});

  @override
  State<CreateSongGuideScreen> createState() => _CreateSongGuideScreenState();
}

class _CreateSongGuideScreenState extends State<CreateSongGuideScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final TextStyle titleStyle =
        bold22.copyWith(color: colors.colorScheme.primary);
    final TextStyle chordStyle =
        bold14.copyWith(color: colors.colorScheme.primary);

    return Scaffold(
      appBar: AppBar(
          // title: const Text('Guía'),
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIntroChords(
                  chordStyle: chordStyle,
                  titleStyle: titleStyle,
                ),
                const SizedBox(height: 35),
                _buildLyricChords(
                  chordStyle: chordStyle,
                  titleStyle: titleStyle,
                ),
                const SizedBox(height: 35),
                _buildLyricChordsInside(
                  chordStyle: chordStyle,
                  titleStyle: titleStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroChords({
    required TextStyle chordStyle,
    required TextStyle titleStyle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('1. Introducción de acordes', style: titleStyle),
        const Text(
          'Nota el espacio entre el acorde y el ultimo corchete',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        const CustomInput(
          readOnly: true,
          initialValue: "[C ][Am ][F ][G ]",
        ),
        const Icon(Icons.arrow_downward_rounded),
        _buildPreview("[C ][Am ][F ][G ]"),
      ],
    );
  }

  Widget _buildLyricChords({
    required TextStyle chordStyle,
    required TextStyle titleStyle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('2. Escribe acordes con letra', style: titleStyle),
        const SizedBox(height: 10),
        const CustomInput(
          maxLines: 4,
          minLines: 3,
          readOnly: true,
          initialValue:
              "[C]I will [Em]leave my heart at the door\n[F]I won't say a word\n[G]They've all been said before, you know\n",
        ),
        const Icon(Icons.arrow_downward_rounded),
        _buildPreview(
            "[C]I will [Em]leave my heart at the door\n[F]I won't say a word\n[G]They've all been said before, you know\n"),
      ],
    );
  }

  Widget _buildLyricChordsInside({
    required TextStyle chordStyle,
    required TextStyle titleStyle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('3. Escribe acorde entre letras', style: titleStyle),
        const Text(
          'Si necesitas mas acordes en una sola palabra puedes usar esto:',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const CustomInput(
          readOnly: true,
          initialValue: "[B]Uhh[F#m]hhhh[C#m]hhh \n",
        ),
        const Icon(Icons.arrow_downward_rounded),
        _buildPreview("[B]Uhh[F#m]hhhh[C#m]hhh \n"),
      ],
    );
  }

  Widget _buildPreview(String lyricPreview) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        // const Text('Vista previa', style: bold20),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              child: LyricsRenderer(
                horizontalAlignment: CrossAxisAlignment.start,
                widgetPadding: (size.width * 0.3).round(),
                lyrics: lyricPreview,
                textStyle: normal16.copyWith(color: colors.onSurface),
                chordStyle: bold16.copyWith(color: colors.primary),
                onTapChord: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
