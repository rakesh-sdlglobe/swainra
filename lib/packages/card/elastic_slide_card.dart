import 'package:flutter/material.dart';

class SwainraElasticSlideCard extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SwainraElasticSlideCard({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<SwainraElasticSlideCard> createState() => _SwainraElasticSlideCardState();
}

class _SwainraElasticSlideCardState extends State<SwainraElasticSlideCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _rotation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _rotation = Tween<double>(begin: -0.1, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    super.initState();
  }

  @override
  void dispose() => _controller.dispose();

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: RotationTransition(
        turns: _rotation,
        child: widget.child,
      ),
    );
  }
}
