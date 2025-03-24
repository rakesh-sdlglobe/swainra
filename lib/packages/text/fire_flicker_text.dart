import 'package:flutter/material.dart';
import 'dart:math';

class SwainraFireFlickerText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const SwainraFireFlickerText({super.key, required this.text, required this.style});

  @override
  State<SwainraFireFlickerText> createState() => _SwainraFireFlickerTextState();
}

class _SwainraFireFlickerTextState extends State<SwainraFireFlickerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double opacity = 1;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {
          opacity = Random().nextBool() ? 1 : 0.4 + Random().nextDouble() * 0.6;
        });
      })
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
    return Opacity(
      opacity: opacity,
      child: Text(widget.text, style: widget.style),
    );
  }
}
