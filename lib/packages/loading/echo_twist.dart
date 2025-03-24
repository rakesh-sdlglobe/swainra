import 'dart:math';
import 'package:flutter/material.dart';

class EchoTwist extends StatefulWidget {
  const EchoTwist({super.key, this.size = 120});
  final double size;

  @override
  State<EchoTwist> createState() => _EchoTwistState();
}

class _EchoTwistState extends State<EchoTwist> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: EchoTwistPainter(animation: _controller),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class EchoTwistPainter extends CustomPainter {
  EchoTwistPainter({required this.animation}) : super(repaint: animation);
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 5; i++) {
      final progress = (animation.value + i * 0.2) % 1;
      final radius = size.width * progress;
      paint.color = Colors.blueAccent.withOpacity(1 - progress);
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}