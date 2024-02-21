// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:reper/config/theme/theme.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/domain/entities/song.dart';
import 'package:reper/presentation/providers/database/songs_repository_provider.dart';
import 'package:reper/presentation/providers/database/user_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class CreateSongScreen extends ConsumerStatefulWidget {
  const CreateSongScreen({super.key});

  @override
  CreateSongScreenState createState() => CreateSongScreenState();
}

class CreateSongScreenState extends ConsumerState<CreateSongScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _songLyricController = TextEditingController();
  final TextEditingController _songArtistController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Ingresa una Canción!', style: bold24),
                const SizedBox(height: 25),
                CustomInput(
                  controller: _songNameController,
                  label: 'Nombre del Grupo:',
                  hintText: 'Nombra la Canción',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nombra a la canción';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  controller: _songArtistController,
                  label: 'Artista: *opcional',
                  hintText: '¿Quién es el artista?',
                ),
                CustomInput(
                  label: 'Letra de la canción:',
                  hintText: 'Escribe la letra de la canción...',
                  maxLines: null,
                  minLines: 10,
                  controller: _songLyricController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Escribe la letra de la canción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                CustomFilledButton(
                  text: 'Crea el canción',
                  isLoading: isLoading,
                  onTap: () {
                    _createSong();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createSong() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      final res = await ref.read(songsRepositoryProvider).createSong(
            user: ref.read(userProvider),
            song: Song(
              id: 'no-id',
              createdBy: AppUser.empty(),
              title: _songNameController.text,
              lyrics: _songLyricController.text,
              artist: _songArtistController.text.isEmpty
                  ? 'Unknown'
                  : _songArtistController.text,
              images: [],
              pdfFile: '',
            ), 
          );
      isLoading = false;
      setState(() {});
      showSnackbarResponse(
        context: context,
        response: res,
      );
      if (!res.hasError) {
        context.pop();
      }
    }
  }
}
