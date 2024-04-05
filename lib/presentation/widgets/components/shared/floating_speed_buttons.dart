import 'package:flutter/material.dart';

class FloatingSpeedButtons extends StatefulWidget {
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  final void Function()? onPause;

  const FloatingSpeedButtons({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.onPause,
  });

  @override
  State<FloatingSpeedButtons> createState() => _FloatingSpeedButtonsState();
}

class _FloatingSpeedButtonsState extends State<FloatingSpeedButtons> {
  bool isIncrement = true;

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context);
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        if (widget.onIncrement != null && widget.onPause != null) {
          if (isIncrement) {
            widget.onIncrement!();
            isIncrement = false;
          } else {
            widget.onPause!();
            isIncrement = true;
          }
          setState(() {});
        }
      },
      child: isIncrement ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
    );
  }
}
