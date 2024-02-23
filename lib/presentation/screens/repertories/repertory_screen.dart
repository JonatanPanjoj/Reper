// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/theme.dart';

import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/repertory_repository_provider.dart';
import 'package:reper/presentation/providers/providers.dart';
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
          return StreamBuilder(
              stream: ref.watch(sectionRepositoryProvider).streamSections(
                  groupId: widget.repertory.groupId,
                  repertoryId: widget.repertory.id),
              builder: (context, snapshot) {
                final sections = snapshot.data;
                if (sections == null) {
                  return const Center(child: CustomLoading());
                }
                if (sections.isNotEmpty) {
                  sections.sort((a, b) => a.position.compareTo(b.position));
                }
                return CustomScrollView(
                  slivers: [
                    _buildAppBar(size, sections),
                    _buildAddSongTile(sections),
                    if (sections.isEmpty) _buildNoSongsMessage(),
                    if (sections.isNotEmpty)
                      SliverList.builder(
                        itemCount: sections.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Builder(builder: (context) {
                            return CardTypeThree(
                              title: sections[index].name,
                              subtitle: sections[index].song.title,
                              onTap: () {
                                context.push('/section-screen', extra: {
                                  'section': sections[index],
                                  'image': widget.repertory.image
                                });
                              },
                            );
                          });
                        },
                      )
                  ],
                );
              });
        },
      ),
    );
  }

  CustomSliverAppBar _buildAppBar(Size size, List<Section?> sections) {
    return CustomSliverAppBar(
      height: size.height * 0.2,
      image: widget.repertory.image,
      title: widget.repertory.name,
      subtitle: '${sections.length} canciones',
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

  SliverToBoxAdapter _buildAddSongTile(List<Section?> sections) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            selectedSong = await context.push('/library-screen');
            if (selectedSong != null) {
              _createSection(selectedSong!, sections);
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

  void _createSection(Song selectedSong, List<Section?> sections) async {
    final repertorySections = sections;
    repertorySections.sort((a, b) => a!.position.compareTo(b!.position));

    final addSection = Section(
      id: const Uuid().v4(),
      name: repertorySections.isEmpty
          ? 'Sección 1'
          : 'Sección ${repertorySections.last!.position + 1}',
      song: Song(
        id: selectedSong.id,
        title: selectedSong.title,
        lyrics: selectedSong.lyrics,
        artist: selectedSong.artist,
        images: selectedSong.images,
        pdfFile: selectedSong.pdfFile,
      ),
      position:
          repertorySections.isEmpty ? 1 : repertorySections.last!.position + 1,
    );
    final res = await ref.read(sectionRepositoryProvider).createSection(
          groupId: widget.repertory.groupId,
          repertoryId: widget.repertory.id,
          section: addSection,
        );

    if (res.hasError) {
      showSnackBar(context: context, message: res.message);
    }
  }
}
