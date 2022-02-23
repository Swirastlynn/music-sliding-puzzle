import 'dart:math';

import 'package:flutter/widgets.dart';

// Concept based on:
// https://codewithandrea.com/articles/shake-text-effect-flutter/
class ShakeAnimationWidget extends StatefulWidget {
  const ShakeAnimationWidget({
    Key? key,
    required this.child,
    this.shakeOffset = 4.0,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final Widget child;

  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  ShakeAnimationWidgetState createState() => ShakeAnimationWidgetState(shakeDuration);
}

class ShakeAnimationWidgetState extends AnimationControllerState<ShakeAnimationWidget> {
  ShakeAnimationWidgetState(Duration duration) : super(duration);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (context, child) {
        final sineValue = sin(widget.shakeCount * 2 * pi * animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }
}

abstract class AnimationControllerState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);

  final Duration animationDuration;
  late final animationController = AnimationController(vsync: this, duration: animationDuration);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}