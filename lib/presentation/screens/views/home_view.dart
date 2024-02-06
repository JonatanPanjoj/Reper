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
    super.build(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Tus Grupos'),
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
                    for (final group in data)
                      CardTypeOne(
                        title: group.name,
                        subtitle: '1 Participante, 0 Canciones',
                      ),
                    FilledButton(
                      onPressed: () {
                        context.push('/create-group');
                      },
                      child: Text('Agregar Grupo'),
                    )
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
