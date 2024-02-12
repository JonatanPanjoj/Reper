import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class CardTypeOne extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int? index;
  final void Function()? onTap;
  final double? animateFrom;
  final Future<void> Function()? onDelete;

  const CardTypeOne({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    required this.imageUrl,
    this.animateFrom,
    this.index,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final size = MediaQuery.of(context).size;

    late AnimationController animateController;
    const animationDuration = Durations.long1;
    const delayAnimation = Durations.long2;

    return FadeOutLeft(
      manualTrigger: true,
      duration: animationDuration,
      controller: (controller) => animateController = controller,
      child: FadeInRight(
        from: animateFrom ?? 100,
        child: Dismissible(
          key: ValueKey(index),
          direction: DismissDirection.endToStart,
          background: _buildDismissibleBackground(colors),
          confirmDismiss: (direction) async {
            final res = await showCustomDialog(
              context: context,
              alertDialog: const DeleteGroupDialog(),
            );
            if (res == true && onDelete != null) {
              animateController.forward();
              await Future.delayed(delayAnimation);
              onDelete!();
            }
            return false;
          },
          child: _buildCard(size),
        ),
      ),
    );
  }

  Widget _buildDismissibleBackground(ThemeData colors) {
    return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                color: colors.colorScheme.error,
              ),
              const Positioned(
                right: 10,
                child: Icon(Icons.delete),
              ),
            ],
          ),
        );
  }

  Widget _buildCard(Size size) {
    return GestureDetector(
          onTap: onTap,
          child: Card(
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    height: size.width * 0.25,
                    width: size.width * 0.223,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(
                            'assets/loaders/bottle-loader.gif'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: bold18,
                        ),
                        const SizedBox(height: 2),
                        Text(subtitle),
                        const SizedBox(height: 2),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 9,
                              color: Colors.green,
                            ),
                            SizedBox(width: 10),
                            Text('Active')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
  }
}
