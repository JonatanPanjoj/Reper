import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({
    super.key,
    this.color = Colors.white,
  });

  final Color color;

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> firstCircle;
  late Animation<double> secondCircle;
  late Animation<double> thirdCircle;
  late Animation<double> opacity;

  double begin = 0;
  double end = 5;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    firstCircle = getOffsetAnimation(0.0, 0.4);
    secondCircle = getOffsetAnimation(0.2, 0.6);
    thirdCircle = getOffsetAnimation(0.4, 0.8);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 1.0, curve: Curves.easeIn),
      ),
    );
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Animation<double> getOffsetAnimation(double lowLimit, double upperLimit) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(lowLimit, upperLimit, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.view,
      builder: (BuildContext context, _) {
        return Opacity(
          opacity: opacity.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircle(firstCircle.value),
              const SizedBox(
                width: 4,
              ),
              _buildCircle(secondCircle.value),
              const SizedBox(
                width: 4,
              ),
              _buildCircle(thirdCircle.value),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCircle(double verticalPosition) {
    return Transform.translate(
      offset: Offset(0, verticalPosition),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
      ),
    );
  }
}
