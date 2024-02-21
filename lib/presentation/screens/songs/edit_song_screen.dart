// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class EditSongScreen extends ConsumerStatefulWidget {
  final Song song;

  const EditSongScreen({super.key, required this.song});

  @override
  EditSongScreenState createState() => EditSongScreenState();
}

class EditSongScreenState extends ConsumerState<EditSongScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _lyricController = TextEditingController();
  String lyricPreview = '';
  bool isLoading = false;

  @override
  void initState() {
    _titleController.text = widget.song.title;
    _artistController.text = widget.song.artist;
    _lyricController.text = widget.song.lyrics;
    lyricPreview = widget.song.lyrics;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Song'),
        actions: [
          TextButton(
            onPressed: () {
              _updateSong();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                CustomInput(
                  label: 'Titulo:',
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La canción no puede estár vacía';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomInput(
                  label: 'Artista:',
                  controller: _artistController,
                ),
                const SizedBox(height: 15),
                CustomInput(
                  label: 'Letra:',
                  controller: _lyricController,
                  onChanged: (value) {
                    lyricPreview = value.replaceAll('[]', '[');
                    setState(() {});
                  },
                  maxLines: null,
                  minLines: 10,
                ),
                const SizedBox(height: 35),
                _buildPreview(size, colors)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(Size size, ColorScheme colors) {
    return Column(
      children: [
        const Text('Vista previa', style: bold20),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15, vertical: 10),
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
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }

  void _updateSong() async {
    print('Entre xdd');
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final res = await ref.read(songsRepositoryProvider).updateSong(
            song: Song(
              id: widget.song.id,
              createdBy: widget.song.createdBy,
              title: _titleController.text,
              lyrics: _lyricController.text,
              artist: _artistController.text.isEmpty
                  ? 'Unknown'
                  : _artistController.text,
              images: widget.song.images,
              pdfFile: widget.song.pdfFile,
            ),
          );
      setState(() {
        isLoading = false;
      });

      if (res.hasError) {
        showSnackbarResponse(
          context: context,
          response: res,
        );
        return;
      }
      context.pop();
    }
  }
}
