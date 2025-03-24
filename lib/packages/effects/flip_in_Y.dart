import 'package:flutter/material.dart';

class SwainraFlipInY extends StatefulWidget {
  final Widget child;
  const SwainraFlipInY({super.key, required this.child});

  @override
  State<SwainraFlipInY> createState() => _SwainraFlipInYState();
}

class _SwainraFlipInYState extends State<SwainraFlipInY> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this);
    _animation = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(_animation.value),
          alignment: Alignment.center,
          child: Opacity(opacity: (_animation.value + 1).clamp(0.0, 1.0), child: child),
        );
      },
    );
  }
}
