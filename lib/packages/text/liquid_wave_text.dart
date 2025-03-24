import 'package:flutter/material.dart';

class SwainraLiquidWaveText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const SwainraLiquidWaveText({super.key, required this.text, required this.style});

  @override
  State<SwainraLiquidWaveText> createState() => _SwainraLiquidWaveTextState();
}

class _SwainraLiquidWaveTextState extends State<SwainraLiquidWaveText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
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
      animation: _controller,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [Colors.transparent, Colors.white, Colors.transparent],
              stops: const [0.0, 0.5, 1.0],
              transform:
                  GradientRotation(_controller.value * 2 * 3.1415926535),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Text(widget.text, style: widget.style),
        );
      },
    );
  }
}
