import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/app_font_styles.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/repertory_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class GroupScreen extends ConsumerStatefulWidget {
  final Group group;

  const GroupScreen({super.key, required this.group});
  
  @override
  GroupScreenState createState() => GroupScreenState();
}

class GroupScreenState extends ConsumerState<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: _repertoriesStream(),
        builder: (context, snapshot) {
          final repertories = snapshot.data;
          if (repertories == null) {
            return const Center(child: CustomLoading());
          }
          return CustomScrollView(
            slivers: [
              _buildAppBar(
                size: size,
                context: context,
                repertories: repertories,
              ),
              _buildBody(
                repertories: repertories,
                context: context,
              )
            ],
          );
        },
      ),
    );
  }

  SliverToBoxAdapter _buildBody({
    required BuildContext context,
    required List<Repertory> repertories,
  }) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            if (repertories.isEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    showCustomDialog(
                      context: context,
                      alertDialog: AddReperDialog(groupId: widget.group.id),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 50,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Agregar una Repertorio',
                        style: normal20,
                      )
                    ],
                  ),
                ),
              )
            else
              Column(
                children: [
                  for (int i = 0; i < repertories.length; i++)
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        CardTypeTwo(
                          animateFrom: 100 + (i * 300),
                          title: repertories[i].name,
                          subtitle:
                              '${repertories[i].sections.length} Canciones',
                          imageUrl: repertories[i].image,
                          index: i,
                          onTap: () {
                            context.push('/repertory', extra: repertories[i]);
                          },
                          deleteDialogWidget: const DeleteRepertoryDialog(),
                          onDelete: () async {
                            await ref
                                .read(repertoryRepositoryProvider)
                                .deleteRepertory(
                                  repId: repertories[i].id,
                                  groupId: widget.group.id,
                                );
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }

  CustomSliverAppBar _buildAppBar({
    required Size size,
    required BuildContext context,
    required List<Repertory> repertories,
  }) {
    return CustomSliverAppBar(
      title: widget.group.name,
      subtitle: '${repertories.length} repertorios',
      height: size.height * 0.5,
      image: widget.group.image,
      bottomAction: IconButton(
        onPressed: () {
          context.push('/edit-group-screen', extra: {'group': widget.group});
        },
        icon: const Icon(Icons.edit),
      ),
    );
  }

  Stream<List<Repertory>> _repertoriesStream() {
    return ref
        .watch(repertoryRepositoryProvider)
        .streamRepertoriesById(repId: widget.group.id);
  }
}
