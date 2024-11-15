import 'dart:ffi';

import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child; //child is like the like button that will animate
  final bool isAnimating;
  final Duration duration; //how long the like animation happen
  final VoidCallback? onEnd; //to end the like animation
  final bool smallLike; //whether the small like button was clicked

  const LikeAnimation(
      {super.key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 150),
      this.onEnd,
      this.smallLike = false});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    //NOTE: ~/2 divides the value by 2 and converts to int
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
    super.initState();
  }

  /*this function is required to make sure that the animation has completed before another animation takes place
    otherwise it will get stuck */
  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 200));

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
