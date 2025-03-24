import 'package:flutter/material.dart';

class SwainraTextReveal extends StatefulWidget {
  final String text;
  final TextStyle style;

  const SwainraTextReveal({super.key, required this.text, required this.style});

  @override
  State<SwainraTextReveal> createState() => _SwainraTextRevealState();
}

class _SwainraTextRevealState extends State<SwainraTextReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    _revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _revealAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            stops: [_revealAnimation.value, _revealAnimation.value],
            colors: const [Colors.white, Colors.transparent],
          ).createShader(rect),
          blendMode: BlendMode.dstIn,
          child: Text(widget.text, style: widget.style),
        );
      },
    );
  }
}
