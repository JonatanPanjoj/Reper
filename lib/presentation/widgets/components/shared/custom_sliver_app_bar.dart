import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomSliverAppBar extends ConsumerWidget {
  final String? title;
  final String? subtitle;
  final double? height;
  final bool floating;
  final String image;
  final Widget? bottomAction;
  final List<Widget>? actions;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.subtitle,
    required this.height,
    required this.image,
    this.floating = true,
    this.bottomAction,
    this.actions
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = ref.watch(themeNotifierProvider).isDarkMode;
    final colors = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      actions: actions,
      collapsedHeight: size.height * 0.12,
      expandedHeight: height == null
          ? (size.height * 0.5).round().toDouble()
          : height!.round().toDouble(),
      titleSpacing: 0,
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
                    stops: !isDark
                        //LIGHT MODE
                        ? [0.1, 0.4, 1]
                        //DARK MODE
                        : [0.1, 1],
                    colors: (!isDark)
                        ? [
                            Colors.transparent,
                            colors.colorScheme.primary.withOpacity(0.1),
                            colors.scaffoldBackgroundColor,
                          ]
                        : [
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
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      title ?? '',
                      style: GoogleFonts.urbanist(fontSize: 25).copyWith(
                          color: colors.colorScheme.onSurface,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: [
                  Text(
                    subtitle ?? '',
                    style: GoogleFonts.urbanist(fontSize: 12).copyWith(
                      color: colors.colorScheme.onSurface,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            bottomAction != null
                ? Positioned(
                    right: 5,
                    bottom: 20,
                    child: bottomAction!,
                  )
                : const SizedBox(),
          ],
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: FadeInImage.memoryNetwork(
                  image: image,
                  placeholder: (kTransparentImage),
                  fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
