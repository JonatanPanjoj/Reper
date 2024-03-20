import 'package:flutter/material.dart';
import 'package:reper/domain/entities/entities.dart';

class UserTile extends StatelessWidget {
  final AppUser user;
  const UserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            user.image.isEmpty
            ? CircleAvatar(child: Text('${user.name.substring(0,1)}'),)
            :
            CircleAvatar(
              backgroundImage: NetworkImage(user.image),
            ),
            const SizedBox(width: 10),
            Text(user.name)
          ],
        ),
        const Expanded(child: SizedBox()),
        Icon(
          Icons.wifi_rounded,
          color: colors.dividerColor,
        )
      ],
    );
  }
}
