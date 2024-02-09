import 'package:flutter/material.dart';

Future<dynamic> showCustomDialog({
  required BuildContext context,
  required Widget alertDialog,
}) async {
  return await showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => alertDialog,
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      final double scale = Curves.easeInOutCirc.transform(animation.value);
      return Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: animation.value,
          child: child,
        ),
      );
    },
  );
}
