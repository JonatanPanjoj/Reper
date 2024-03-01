import 'package:flutter/material.dart';

//TODO: Pedir el appuser y hacerlo dinámico
class UserTile extends StatelessWidget {
  // final AppUser user;
  const UserTile({
    super.key,
    // required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pbs.twimg.com/media/GBFbUWhXgAI_5nT.jpg:large'),
              
            ),
            const SizedBox(width: 10),
            const Text('SteRodrix')
          ],
        ),
        Expanded(child: SizedBox()),
        Icon(Icons.wifi_rounded, color: colors.dividerColor ,)
      ],
    );
  }
}
