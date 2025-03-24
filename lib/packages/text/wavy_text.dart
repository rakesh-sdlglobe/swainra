import 'package:flutter/material.dart';
import 'dart:math';

class SwainraWavyText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;

  const SwainraWavyText({
    super.key,
    required this.text,
    required this.style,
    this.speed = const Duration(milliseconds: 800),
  });

  @override
  State<SwainraWavyText> createState() => _SwainraWavyTextState();
}

class _SwainraWavyTextState extends State<SwainraWavyText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.speed)..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final characters = widget.text.characters.toList();
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(characters.length, (i) {
            final wave = sin((_controller.value * 2 * pi) + (i * 0.4)) * 8;
            return Transform.translate(
              offset: Offset(0, wave),
              child: Text(characters[i], style: widget.style),
            );
          }),
        );
      },
    );
  }
}
