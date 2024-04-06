// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/presentation/providers/database/repositories/section_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

import '../../../domain/entities/entities.dart';

class SectionScreen extends ConsumerStatefulWidget {
  final Repertory repertory;
  final String image;
  final Section section;
  final Song song;

  const SectionScreen(
      {super.key,
      required this.section,
      required this.image,
      required this.song,
      required this.repertory});

  @override
  SectionScreenState createState() => SectionScreenState();
}

class SectionScreenState extends ConsumerState<SectionScreen> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _sectionNameController = TextEditingController();

  int transposeIncrement = 0;
  int speed = 10;
  bool isEditNameControllerEnabled = false;
  bool hasEdited = false;

  @override
  void initState() {
    _sectionNameController.text = widget.section.name;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
            height: size.height * 0.25,
            image: widget.image,
            bottomAction: IconButton(
              onPressed: () {
                isEditNameControllerEnabled = !isEditNameControllerEnabled;
                if (isEditNameControllerEnabled != true) {
                  updateSection();
                }
                setState(() {});
              },
              icon: isEditNameControllerEnabled
                  ? const Icon(Icons.save)
                  : const Icon(Icons.edit),
            ),
            titleWidget: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextFormField(
                  controller: _sectionNameController,
                  enabled: isEditNameControllerEnabled,
                  style: GoogleFonts.urbanist(fontSize: 20).copyWith(
                    color: colors.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border:
                        isEditNameControllerEnabled ? null : InputBorder.none,
                  ),
                ),
              ),
            ),
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

  void updateSection() async {
    if (_formKey.currentState!.validate()) {
      final res = await ref.read(sectionRepositoryProvider).updateSection(
            section: widget.section.copyWith(name: _sectionNameController.text),
            groupId: widget.repertory.groupId,
            repertoryId: widget.repertory.id,
          );
      hasEdited = true;
      showSnackbarResponse(context: context, response: res);
      context.pop();
      context.pop();
    }
  }
}
