// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/theme.dart';

import 'package:reper/domain/entities/entities.dart';
import 'package:reper/domain/entities/section.dart';
import 'package:reper/presentation/providers/database/repositories/repertory_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class RepertoryScreen extends ConsumerStatefulWidget {
  final Repertory repertory;

  const RepertoryScreen({super.key, required this.repertory});

  @override
  RepertoryScreenState createState() => RepertoryScreenState();
}

class RepertoryScreenState extends ConsumerState<RepertoryScreen> {
  Song? selectedSong;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: ref.watch(repertoryRepositoryProvider).streamRepertory(
              id: widget.repertory.id,
              groupId: widget.repertory.groupId,
            ),
        builder: (context, snapshot) {
          final songs = snapshot.data;
          if (songs == null) {
            return const Center(child: CustomLoading());
          }
          return CustomScrollView(
            slivers: [
              _buildAppBar(size),
              _buildAddSongTile(),
              if (songs.sections.isEmpty) _buildNoSongsMessage(),
              if (songs.sections.isNotEmpty)
                SliverList.builder(
                  itemCount: songs.sections.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardTypeThree(
                      title: songs.sections[index].name,
                      subtitle: songs.sections[index].song.title,
                      onTap: () {
                        context.push('/song-screen', extra: songs.sections[index].song);
                      },
                    );
                  },
                )
            ],
          );
        },
      ),
    );
  }

  CustomSliverAppBar _buildAppBar(Size size) {
    return CustomSliverAppBar(
      height: size.height * 0.2,
      image: widget.repertory.image,
      title: widget.repertory.name,
      subtitle: '${widget.repertory.sections.length} canciones',
    );
  }

  SliverToBoxAdapter _buildNoSongsMessage() {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Text('Aún no tienes canciones agregadas'),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildAddSongTile() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            selectedSong = await context.push('/library-screen');
            if (selectedSong != null) {
              _createSection(selectedSong!);
            }
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
    );
  }

  void _createSection(Song selectedSong) async {
    final repertorySections = widget.repertory.sections;
    repertorySections.sort((a, b) => a.position.compareTo(b.position));

    repertorySections.add(
      Section(
        id: const Uuid().v4(),
        name: repertorySections.isEmpty
            ? 'Sección 1'
            : 'Sección ${repertorySections.last.position + 1}',
        song: Song(
          id: selectedSong.id,
          title: selectedSong.title,
          lyrics: selectedSong.lyrics,
          artist: selectedSong.artist,
          images: selectedSong.images,
          pdfFile: selectedSong.pdfFile,
        ),
        position:
            repertorySections.isEmpty ? 1 : repertorySections.last.position + 1,
      ),
    );
    final res =
        await ref.read(repertoryRepositoryProvider).createRepertorySection(
              repertory: widget.repertory.copyWith(sections: repertorySections),
              groupId: widget.repertory.groupId,
            );

    if (res.hasError) {
      showSnackBar(context: context, message: res.message);
    }
  }
}
