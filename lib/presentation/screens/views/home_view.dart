import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/domain/entities/group.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/components/shared/empty_groups.dart';
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
    return StreamBuilder(
      stream: _streamGroups(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return const SizedBox();
        }
        if (data.isEmpty) {
          return const NoGroupsView();
        }
        return Scaffold(
          body: CustomScrollView(
            slivers: [_buildAppBar(colors, context), _buildBody(data, context)],
          ),
        );
      },
    );
  }

  SliverToBoxAdapter _buildBody(List<Group> data, BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            for (int i = 0; i < data.length; i++)
              Column(
                children: [
                  const SizedBox(height: 15),
                  _buildCard(data, i, context),
                ],
              ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(ColorScheme colors, BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: Text(
        'Mis Grupos',
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
    );
  }

  Widget _buildCard(List<Group> data, int i, BuildContext context) {
    return CardTypeOne(
      title: data[i].name,
      subtitle: '${data[i].repertories.length} repertorios',
      actionWidget: Row(
        children: [
          Text(
            data[i].users!.length.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.group,
            size: 15,
          ),
        ],
      ),
      imageUrl: data[i].image,
      animateFrom: 100 + (i * 100),
      onTap: () {
        context.push('/group-screen', extra: data[i]);
      },
      deleteDialogWidget: const DeleteGroupDialog(),
      index: i,
      onDelete: () async {
        ref.read(groupProvider).deleteGroup(
              groupId: data[i].id,
            );
      },
    );
  }

  Stream<List<Group>> _streamGroups() {
    return ref.watch(groupProvider).streamGroupsById(
          groups: ref.watch(userProvider).groups!,
        );
  }

  @override
  bool get wantKeepAlive => true;
}
