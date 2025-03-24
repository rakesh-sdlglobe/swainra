import 'package:flutter/material.dart';

class SwainraColorMorphText extends StatefulWidget {
  final String text;
  final double fontSize;

  const SwainraColorMorphText({super.key, required this.text, this.fontSize = 28});

  @override
  State<SwainraColorMorphText> createState() => _SwainraColorMorphTextState();
}

class _SwainraColorMorphTextState extends State<SwainraColorMorphText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Shader _shader(Rect bounds) {
    return LinearGradient(
      colors: const [Colors.blue, Colors.pink, Colors.orange],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [_controller.value, _controller.value + 0.3, _controller.value + 0.6],
      tileMode: TileMode.mirror,
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: _shader,
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
