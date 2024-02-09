import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repertory_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class GroupScreen extends ConsumerWidget {
  final Group group;

  const GroupScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: group.name,
            subtitle: '${group.reps.length} canciones',
            height: size.height * 0.5,
            image: group.image,
            bottomAction: IconButton(
              onPressed: () {
                showCustomDialog(
                  context: context,
                  alertDialog: AddReperDialog(groupId: group.id),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder(
                stream: ref
                    .watch(repertoryRepositoryProvider)
                    .streamRepertoriesById(repId: group.id),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null) {
                    return const Center(child: CustomLoading());
                  }
                  if (data.isEmpty) {
                    return const Column(
                      children: [
                        SizedBox(height: 50),
                        Text('Aún no tienes repertorios creados'),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      for(int i = 0; i < data.length; i++)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          CardTypeTwo(
                            animateFrom: 100 + (i * 300),
                            title: data[i].name,
                            subtitle: '${data[i].sections.length} Canciones',
                            imageUrl: data[i].image,
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
