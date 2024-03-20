import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class SocialView extends ConsumerStatefulWidget {
  const SocialView({super.key});

  @override
  SocialViewState createState() => SocialViewState();
}

class SocialViewState extends ConsumerState<SocialView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: StreamBuilder(
        stream: ref
            .watch(userRepositoryProvider)
            .streamUserFriends(friends: ref.watch(userProvider).friends!),
        builder: (context, snapshot) {
          final friends = snapshot.data;
          if (friends == null) {
            return const SizedBox();
          }
          if (friends.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Mis Amigos'),
                actions: [
                  _buildAddFriend()
                ],
              ),
              body: const Center(
                child: Text('Aún no tienes amigos'),
              ),

            );
          }
          return _buildBody(context, friends);
        },
      ),
    );
  }

  CustomScrollView _buildBody(
      BuildContext context, List<AppUser> friends) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Mis Amigos'),
          floating: true,
          elevation: 0,
          shadowColor: Colors.transparent,
          actions: [
            _buildAddFriend()
          ],
        ),
        const SliverSizedBox(height: 5),
        SliverList.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: UserTile(user: friends[index],),
            );
          },
        )
      ],
    );
  }

  IconButton _buildAddFriend() {
    final colors = Theme.of(context);
    return IconButton(
            onPressed: () {
              showCustomDialog(
                  context: context, alertDialog: const AddFriendDialog());
            },
            icon: const Icon(Icons.person_add_alt_1_rounded),
            color: colors.colorScheme.primary,
          );
  }

  @override
  bool get wantKeepAlive => true;
}
