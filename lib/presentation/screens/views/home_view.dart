import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    super.build(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text(
            'Tus Grupos',
            style: TextStyle(color: colors.onSurface),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                context.push('/create-group');
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Crear Grupo',
                style: TextStyle(color: colors.primary),
              ),
            )
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder(
              stream: ref.watch(groupProvider).streamGroupsById(
                    groups: ref.watch(userProvider).groups!,
                  ),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data == null) {
                  return const SizedBox();
                }
                return Column(
                  children: [
                    const SizedBox(height: 15),
                    for (int i = 0; i < data.length; i++)
                      Column(
                        children: [
                          CardTypeOne(
                            title: data[i].name,
                            subtitle: '1 Participante, 0 Canciones',
                            imageUrl: data[i].image,
                            animateFrom: 100 + (i * 100),
                            onTap: () {
                              context.push('/group-screen', extra: data[i]);
                            },
                          ),
                          const SizedBox(height: 15)
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
