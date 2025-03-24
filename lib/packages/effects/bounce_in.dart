import 'package:flutter/material.dart';

class SwainraBounceIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SwainraBounceIn({Key? key, required this.child, this.duration = const Duration(milliseconds: 700)}) : super(key: key);

  @override
  State<SwainraBounceIn> createState() => _SwainraBounceInState();
}

class _SwainraBounceInState extends State<SwainraBounceIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _bounce = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 0.9), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 0.9, end: 1.0), weight: 25),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _bounce, child: widget.child);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
