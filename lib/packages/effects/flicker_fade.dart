import 'package:flutter/material.dart';

class SwainraFlickerFade extends StatefulWidget {
  final Widget child;
  const SwainraFlickerFade({super.key, required this.child});

  @override
  State<SwainraFlickerFade> createState() => _SwainraFlickerFadeState();
}

class _SwainraFlickerFadeState extends State<SwainraFlickerFade> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  )..forward();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.3), weight: 10),
        TweenSequenceItem(tween: Tween(begin: 0.3, end: 0.0), weight: 10),
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 80),
      ]).animate(_controller),
      child: widget.child,
    );
  }
}
