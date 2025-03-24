import 'dart:math';
import 'package:flutter/material.dart';

class SwainraNovaGlow extends StatefulWidget {
  const SwainraNovaGlow({super.key, this.size = 100});
  final double size;

  @override
  State<SwainraNovaGlow> createState() => _SwainraNovaGlowState();
}

class _SwainraNovaGlowState extends State<SwainraNovaGlow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: NovaGlowPainter(animation: _controller),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class NovaGlowPainter extends CustomPainter {
  NovaGlowPainter({required this.animation}) : super(repaint: animation);
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 3;
    final outerRadius = size.width / 2;

    final progress = animation.value;
    final paint = Paint()..style = PaintingStyle.stroke;

    for (int i = 0; i < 12; i++) {
      final angle = 2 * pi * (i / 12 + progress);
      final start = Offset(center.dx + cos(angle) * radius, center.dy + sin(angle) * radius);
      final end = Offset(center.dx + cos(angle) * outerRadius, center.dy + sin(angle) * outerRadius);

      paint.color = Colors.orange.withOpacity(1 - (i / 12));
      paint.strokeWidth = 2 + (i % 3);
      canvas.drawLine(start, end, paint);
    }

    final innerGlow = Paint()
      ..color = Colors.orangeAccent.withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(center, radius / 2, innerGlow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}