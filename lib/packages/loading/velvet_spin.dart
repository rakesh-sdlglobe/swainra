import 'dart:math';
import 'package:flutter/material.dart';

class SwainraVelvetSpin extends StatefulWidget {
  const SwainraVelvetSpin({super.key, this.size = 100});
  final double size;

  @override
  State<SwainraVelvetSpin> createState() => _SwainraVelvetSpintate();
}

class _SwainraVelvetSpintate extends State<SwainraVelvetSpin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: VelvetSpinPainter(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class VelvetSpinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.deepPurple, Colors.purpleAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    for (double i = 0; i < 360; i += 2) {
      double radians = i * pi / 180;
      double x = size.width / 2 + cos(radians) * (size.width / 2 - 10);
      double y = size.height / 2 + sin(radians) * (size.height / 2 - 10);
      path.lineTo(x, y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}