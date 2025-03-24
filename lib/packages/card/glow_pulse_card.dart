import 'package:flutter/material.dart';

class SwainraGlowPulseCard extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double borderRadius;
  final double padding;

  const SwainraGlowPulseCard({
    super.key,
    required this.child,
    this.glowColor = Colors.cyanAccent,
    this.borderRadius = 20,
    this.padding = 16,
  });

  @override
  State<SwainraGlowPulseCard> createState() => _SwainraGlowPulseCardState();
}

class _SwainraGlowPulseCardState extends State<SwainraGlowPulseCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.2, end: 0.9).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    super.initState();
  }

  @override
  void dispose() => _controller.dispose();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (_, __) => Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: widget.glowColor.withOpacity(_glowAnimation.value),
              blurRadius: 20,
              spreadRadius: 2,
            )
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
