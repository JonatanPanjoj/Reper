import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reper/presentation/providers/providers.dart';

import 'package:reper/config/theme/theme.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class CustomFilledButton extends ConsumerWidget {
  final void Function()? onTap;
  final String text;
  final double size;
  final double height;
  final bool isLoading;
  final Widget? icon;
  final Color? color;
  final Color? fontColor;

  const CustomFilledButton({
    super.key,
    this.onTap,
    this.size = double.infinity,
    this.height = 50,
    required this.text,
    this.isLoading = false,
    this.icon,
    this.color,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final isDarkMode = ref.watch(isDarkModeProvider);
    final backgroundColor = isDarkMode ? primaryDark : primaryDark;
    return SizedBox(
      width: size,
      height: height,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onTap,
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(colors.onSurface),
            backgroundColor: MaterialStatePropertyAll(color ?? backgroundColor),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            )),
        label: Center(
          child: isLoading
              ? const CustomLoading()
              : Text(
                  text,
                  style: bold14.copyWith(color: fontColor ?? Colors.white),
                ),
        ),
        icon: icon ?? const SizedBox(),
      ),
    );
  }
}
