import 'package:flutter/material.dart';

class SwainraWaveRevealCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double borderRadius;

  const SwainraWaveRevealCard({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.borderRadius = 20,
  });

  @override
  State<SwainraWaveRevealCard> createState() => _SwainraWaveRevealCardState();
}

class _SwainraWaveRevealCardState extends State<SwainraWaveRevealCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _revealAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();

    _revealAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuart);

    super.initState();
  }

  @override
  void dispose() => _controller.dispose();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AnimatedBuilder(
        animation: _revealAnimation,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                stops: [_revealAnimation.value - 0.1, _revealAnimation.value],
                colors: [Colors.white, Colors.transparent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(rect);
            },
            blendMode: BlendMode.dstIn,
            child: widget.child,
          );
        },
      ),
    );
  }
}
