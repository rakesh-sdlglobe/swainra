import 'package:flutter/material.dart';
import 'dart:math';

class SwainraHelixRise extends StatefulWidget {
  final double size;
  const SwainraHelixRise({super.key, this.size = 100});

  @override
  State<SwainraHelixRise> createState() => _SwainraHelixRiseState();
}

class _SwainraHelixRiseState extends State<SwainraHelixRise>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
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
      painter: _HelixPainter(animation: _controller),
      size: Size.square(widget.size),
    );
  }
}

class _HelixPainter extends CustomPainter {
  final Animation<double> animation;

  _HelixPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()..color = Colors.deepPurpleAccent;
    final dotCount = 50;

    for (int i = 0; i < dotCount; i++) {
      double t = (i / dotCount + animation.value) % 1.0;
      double angle = 2 * pi * t * 3;
      double radius = size.width / 4 * sin(pi * t);
      double x = center.dx + radius * cos(angle);
      double y = center.dy - size.height * (0.5 - t);

      paint.color = Colors.deepPurpleAccent.withOpacity(1 - t);
      canvas.drawCircle(Offset(x, y), 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _HelixPainter oldDelegate) => true;
}
