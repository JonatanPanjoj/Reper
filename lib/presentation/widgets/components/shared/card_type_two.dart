import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class CardTypeTwo extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double? animateFrom;
  final int? index;
  final void Function()? onTap;
  final Future<void> Function()? onDelete;

  const CardTypeTwo({
    super.key,
    this.animateFrom,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
    this.index,
    this.onDelete,
  });

  @override
  State<CardTypeTwo> createState() => _CardTypeTwoState();
}

class _CardTypeTwoState extends State<CardTypeTwo> {
  late AnimationController animateController;
  final animationDuration = Durations.long1;
  final delayAnimation = Durations.long2;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return FadeOutLeft(
      manualTrigger: true,
      duration: animationDuration,
      controller: (controller) => animateController = controller,
      child: FadeInRight(
        from: widget.animateFrom ?? 100,
        child: Dismissible(
          key: ValueKey(widget.index),
          direction: DismissDirection.endToStart,
          background: _buildDismissibleBackground(colors),
          confirmDismiss: (direction) async {
            final res = await showCustomDialog(
              context: context,
              alertDialog: const DeleteRepertoryDialog(),
            );
            if (res == true && widget.onDelete != null) {
              animateController.forward();
              await Future.delayed(delayAnimation);
              widget.onDelete!();
            }
            return false;
          },
          child: _buildCard(colors, size),
        ),
      ),
    );
  }

  ClipRRect _buildDismissibleBackground(ThemeData colors) {
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

  Widget _buildCard(ThemeData colors, Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    primaryDark.withOpacity(0.26),
                    colors.colorScheme.primary.withOpacity(0.10),
                    colors.disabledColor.withOpacity(0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.width * 0.18,
                    width: size.width * 0.18,
                    child: FadeInImage(
                      image: CachedNetworkImageProvider(widget.imageUrl),
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                        'assets/loaders/bottle-loader.gif',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: bold14,
                      ),
                      Text(
                        widget.subtitle,
                        style: normal12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 5,
              child: Text(
                '10 oct 2024',
                style: TextStyle(
                    fontSize: 10, color: colors.colorScheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
