import 'package:flutter/material.dart';

class SwainraScaleFadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const SwainraScaleFadeIn({super.key, required this.child, this.duration = const Duration(milliseconds: 600)});

  @override
  State<SwainraScaleFadeIn> createState() => _SwainraScaleFadeInState();
}

class _SwainraScaleFadeInState extends State<SwainraScaleFadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
