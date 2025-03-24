import 'package:flutter/material.dart';

class SwainraFadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const SwainraFadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeIn,
  });

  @override
  State<SwainraFadeIn> createState() => _SwainraFadeInState();
}

class _SwainraFadeInState extends State<SwainraFadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fadeAnimation, child: widget.child);
  }
}
