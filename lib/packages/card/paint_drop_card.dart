import 'package:flutter/material.dart';

class SwainraPaintDropCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double borderRadius;
  final Color color;

  const SwainraPaintDropCard({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
    this.borderRadius = 24,
    this.color = Colors.indigo,
  });

  @override
  State<SwainraPaintDropCard> createState() => _SwainraPaintDropCardState();
}

class _SwainraPaintDropCardState extends State<SwainraPaintDropCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _dropAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();

    _dropAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    super.initState();
  }

  @override
  void dispose() => _controller.dispose();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScaleTransition(
          scale: _dropAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            padding: const EdgeInsets.all(16),
            child: widget.child,
          ),
        ),
        Positioned(
          top: -30,
          left: 50,
          child: FadeTransition(
            opacity: _dropAnimation,
            child: Icon(Icons.circle, size: 30, color: widget.color.withOpacity(0.4)),
          ),
        ),
        Positioned(
          top: -20,
          right: 40,
          child: FadeTransition(
            opacity: _dropAnimation,
            child: Icon(Icons.circle, size: 25, color: widget.color.withOpacity(0.3)),
          ),
        ),
      ],
    );
  }
}
