import 'package:flutter/material.dart';
import 'dart:math';

class SwainraGalaxyDots extends StatefulWidget {
  final double size;
  const SwainraGalaxyDots({super.key, this.size = 120});

  @override
  State<SwainraGalaxyDots> createState() => _SwainraGalaxyDotsState();
}

class _SwainraGalaxyDotsState extends State<SwainraGalaxyDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
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
    return CustomPaint(
      painter: _GalaxyPainter(animation: _controller),
      size: Size.square(widget.size),
    );
  }
}

class _GalaxyPainter extends CustomPainter {
  final Animation<double> animation;

  _GalaxyPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()..color = Colors.white;
    final starCount = 80;

    for (int i = 0; i < starCount; i++) {
      double angle = (2 * pi * i / starCount) + animation.value * 2 * pi;
      double radius = (i % 2 == 0 ? 1.0 : 0.5) * (size.width / 2);
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);

      paint.color = Colors.primaries[i % Colors.primaries.length]
          .withOpacity(0.6 + 0.4 * sin(animation.value * 2 * pi + i));
      canvas.drawCircle(Offset(x, y), 2.2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GalaxyPainter oldDelegate) => true;
}
