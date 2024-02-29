// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/theme.dart';

import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/repertory_repository_provider.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

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
        stream: _streamRepertory(),
        builder: (context, snapshot) {
          final songs = snapshot.data;
          if (songs == null) {
            return const Center(child: CustomLoading());
          }
          return StreamBuilder(
              stream: _streamSections(),
              builder: (context, snapshot) {
                final sections = snapshot.data;
                if (sections == null) {
                  return const Center(child: CustomLoading());
                }
                if (sections.isNotEmpty) {
                  sections.sort((a, b) => a.position.compareTo(b.position));
                }
                return _buildBody(size, sections, songs);
              });
        },
      ),
    );
  }

  Widget _buildBody(Size size, List<Section> sections, Repertory repertory) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(size, sections, repertory),
        _buildAddSongTile(sections),
        if (sections.isEmpty) _buildNoSongsMessage(),
        if (sections.isNotEmpty)
          SliverList.builder(
            itemCount: sections.length,
            itemBuilder: (BuildContext context, int index) {
              return Builder(
                builder: (context) {
                  return StreamBuilder(
                    stream: ref
                        .watch(songsRepositoryProvider)
                        .streamSong(songId: sections[index].song),
                    builder: (context, snapshot) {
                      final song = snapshot.data;
                      if (song == null) {
                        return const SizedBox();
                      }
                      return CardTypeThree(
                        title: sections[index].name,
                        subtitle: song.title,
                        onTap: () {
                          context.push(
                            '/section-screen',
                            extra: {
                              'section': sections[index],
                              'image': widget.repertory.image,
                              'song': song
                            },
                          );
                        },
                        deleteDialogWidget: const DeleteSectionDialog(),
                        onDelete: () async {
                          await ref
                              .read(sectionRepositoryProvider)
                              .deleteSection(
                                  groupId: widget.repertory.groupId,
                                  repertoryId: widget.repertory.id,
                                  sectionId: sections[index].id);
                        },
                      );
                    },
                  );
                },
              );
            },
          )
      ],
    );
  }

  Stream<List<Section>> _streamSections() {
    return ref.watch(sectionRepositoryProvider).streamSections(
        groupId: widget.repertory.groupId, repertoryId: widget.repertory.id);
  }

  Stream<Repertory> _streamRepertory() {
    return ref.watch(repertoryRepositoryProvider).streamRepertory(
          id: widget.repertory.id,
          groupId: widget.repertory.groupId,
        );
  }

  CustomSliverAppBar _buildAppBar(
      Size size, List<Section?> sections, Repertory repertory) {
    final colors = Theme.of(context);
    return CustomSliverAppBar(
        height: size.height * 0.3,
        image: widget.repertory.image,
        title: widget.repertory.name,
        subtitle: '${sections.length} canciones',
        bottomAction: Stack(
          alignment: Alignment.center,
          children: [
            if (repertory.event != null && repertory.event!.toDate().isAfter(DateTime.now()))
              SpinKitRipple(
                duration: const Duration(seconds: 4),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: primaryDark.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            IconButton(
              color: colors.colorScheme.onSurface,
              onPressed: () {
                context.push(
                  '/add-repertory-event-screen',
                  extra: repertory,
                );
              },
              icon: const Icon(Icons.calendar_month),
            ),
          ],
        ));
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
      id: 'no-id',
      name: repertorySections.isEmpty
          ? 'Sección 1'
          : 'Sección ${repertorySections.last!.position + 1}',
      song: selectedSong.id,
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
