import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final double? height;
  final bool floating;
  final String image;
  final Widget? bottomAction;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.subtitle,
    required this.height,
    required this.image,
    this.floating = true,
    this.bottomAction,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: height == null
          ? (size.height * 0.5).round().toDouble()
          : height!.round().toDouble(),
      titleSpacing: 0,
      floating: floating,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.1, 1],
                    colors: [
                      Colors.transparent,
                      colors.scaffoldBackgroundColor,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              left: 20,
              child: Text(
                title ?? '',
                style: GoogleFonts.urbanist(fontSize: 25).copyWith(
                    color: colors.colorScheme.onSurface,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                subtitle ?? '',
                style: GoogleFonts.urbanist(fontSize: 12).copyWith(
                  color: colors.colorScheme.onSurface,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            bottomAction != null
                ? Positioned(
                    right: 5,
                    bottom: 20,
                    child: bottomAction!,
                  )
                : const SizedBox()
          ],
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: FadeInImage.memoryNetwork(
                image: image,
                placeholder: (kTransparentImage),
                fit: BoxFit.cover
              ),
            ),
          ],
        ),
      ),
    );
  }
}
