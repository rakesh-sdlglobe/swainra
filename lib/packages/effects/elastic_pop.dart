import 'package:flutter/material.dart';

class SwainraElasticPop extends StatefulWidget {
  final Widget child;
  const SwainraElasticPop({super.key, required this.child});

  @override
  State<SwainraElasticPop> createState() => _SwainraElasticPopState();
}

class _SwainraElasticPopState extends State<SwainraElasticPop> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}
