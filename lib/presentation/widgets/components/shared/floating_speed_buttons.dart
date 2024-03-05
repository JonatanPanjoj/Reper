import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingSpeedButtons extends StatelessWidget {
  final ScrollController scrollController;
  final int speed;

  const FloatingSpeedButtons({
    super.key,
    required this.scrollController,
    required this.speed,
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
          onTap: () {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: Duration(
                seconds: ((scrollController.position.maxScrollExtent -
                            scrollController.position.pixels) /
                        speed)
                    .round(),
              ),
              curve: Curves.linear,
            );
          },
        ),
        SpeedDialChild(
          backgroundColor: colors.highlightColor,

          shape: const CircleBorder(),
          child: const Icon(Icons.pause),
          onTap: () {
            scrollController.jumpTo(scrollController.position.pixels);
          },
        ),
        SpeedDialChild(
          backgroundColor: colors.highlightColor,

          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_circle_up_rounded),
          onTap: () {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(
                seconds: ((scrollController.position.pixels -
                            scrollController.position.minScrollExtent) /
                        speed)
                    .round(),
              ),
              curve: Curves.linear,
            );
          },
        ),
      ],
    );
  }
}
