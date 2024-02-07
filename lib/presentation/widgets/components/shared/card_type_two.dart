import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:reper/config/theme/theme.dart';

class CardTypeTwo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double? animateFrom;
  final void Function()? onTap;

  const CardTypeTwo({
    super.key,
    this.animateFrom,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return FadeInRight(
      from: animateFrom ?? 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
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
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(
                          'assets/loaders/bottle-loader.gif',
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: bold14,
                        ),
                        Text(
                          subtitle,
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
      ),
    );
  }
}
