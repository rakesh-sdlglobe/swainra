import 'package:flutter/material.dart';

class SwainraZoomTiltEffect extends StatefulWidget {
  final Widget child;
  const SwainraZoomTiltEffect({super.key, required this.child});

  @override
  State<SwainraZoomTiltEffect> createState() => _SwainraZoomTiltEffectState();
}

class _SwainraZoomTiltEffectState extends State<SwainraZoomTiltEffect> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  )..forward();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(1.0 + 0.1 * (1 - _controller.value))
            ..rotateZ((1 - _controller.value) * 0.1),
          alignment: Alignment.center,
          child: Opacity(opacity: _controller.value, child: child),
        );
      },
    );
  }
}
