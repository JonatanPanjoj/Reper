import 'package:flutter/material.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class SocialView extends StatelessWidget {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Mis Amigos'),
            floating: true,
            elevation: 0,
            shadowColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {
                  showCustomDialog(context: context, alertDialog: const AddFriendDialog());
                },
                icon: const Icon(Icons.person_add_alt_1_rounded),
                color: colors.colorScheme.primary,
              )
            ],
          ),
          const SliverSizedBox(height: 5),
          SliverList.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: UserTile(),
              );
            },
          )
        ],
      ),
    );
  }
}
