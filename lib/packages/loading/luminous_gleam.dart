import 'package:flutter/material.dart';
import 'dart:math';

class SwainraLuminousGleam extends StatefulWidget {
  const SwainraLuminousGleam({super.key, this.size = 100});
  final double size;

  @override
  State<SwainraLuminousGleam> createState() => _SwainraLuminousGleamState();
}

class _SwainraLuminousGleamState extends State<SwainraLuminousGleam> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: LuminousGleamPainter(progress: _controller.value),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LuminousGleamPainter extends CustomPainter {
  final double progress;
  LuminousGleamPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final hexRadius = size.width * 0.3;
    final paint = Paint()
      ..color = Colors.cyan.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 6; i++) {
      final angle = 2 * pi / 6 * i;
      final x = center.dx + cos(angle) * hexRadius;
      final y = center.dy + sin(angle) * hexRadius;
      canvas.drawCircle(Offset(x, y), 10 + sin(progress * 2 * pi + i) * 4, paint);
    }

    final sweepPaint = Paint()
      ..shader = SweepGradient(
        colors: [Colors.white.withOpacity(0.2), Colors.cyanAccent],
        stops: [0.2, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: hexRadius * 1.2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(center, hexRadius * 1.2, sweepPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}