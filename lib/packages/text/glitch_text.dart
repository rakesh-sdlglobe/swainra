import 'package:flutter/material.dart';
import 'dart:math';

class SwainraGlitchText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const SwainraGlitchText({super.key, required this.text, required this.style});

  @override
  State<SwainraGlitchText> createState() => _SwainraGlitchTextState();
}

class _SwainraGlitchTextState extends State<SwainraGlitchText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _randomOffset() {
    final rand = Random();
    return Offset(rand.nextDouble() * 4 - 2, rand.nextDouble() * 4 - 2);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final offset1 = _randomOffset();
        final offset2 = _randomOffset();

        return Stack(
          children: [
            Transform.translate(
              offset: offset1,
              child: Text(widget.text,
                  style: widget.style.copyWith(color: Colors.redAccent)),
            ),
            Transform.translate(
              offset: offset2,
              child: Text(widget.text,
                  style: widget.style.copyWith(color: Colors.blueAccent)),
            ),
            Text(widget.text, style: widget.style),
          ],
        );
      },
    );
  }
}
