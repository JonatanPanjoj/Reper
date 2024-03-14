import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingSpeedButtons extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return SpeedDial(
      mini: true,
      childrenButtonSize: const Size(45, 45),
      renderOverlay: false,
      animatedIcon: AnimatedIcons.play_pause,
      closeManually: true,
      children: [
        SpeedDialChild(
          backgroundColor: colors.highlightColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_circle_down_rounded),
          onTap: onIncrement
        ),
        SpeedDialChild(
          backgroundColor: colors.highlightColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.pause),
          onTap:onPause,
        ),
        SpeedDialChild(
          backgroundColor: colors.highlightColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_circle_up_rounded),
          onTap: onDecrement,
        ),
      ],
    );
  }
}
