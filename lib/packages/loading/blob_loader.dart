import 'dart:math';
import 'package:flutter/material.dart';

class SwainraBlobLoader extends StatefulWidget {
  final double size;

  const SwainraBlobLoader({super.key, this.size = 100});

  @override
  State<SwainraBlobLoader> createState() => _SwainraBlobLoaderState();
}

class _SwainraBlobLoaderState extends State<SwainraBlobLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> points;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
  }

  @override
  void dispose() => _controller.dispose();

  Offset _point(double angle, double variation) {
    return Offset(
      cos(angle) * (widget.size / 2 + sin(_controller.value * 2 * pi + angle) * variation),
      sin(angle) * (widget.size / 2 + cos(_controller.value * 2 * pi + angle) * variation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _BlobPainter(
            center: Offset(widget.size / 2, widget.size / 2),
            points: List.generate(6, (i) => _point(i * pi / 3, 10)),
          ),
        );
      },
    );
  }
}

class _BlobPainter extends CustomPainter {
  final Offset center;
  final List<Offset> points;

  _BlobPainter({required this.center, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..moveTo(center.dx + points[0].dx, center.dy + points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.quadraticBezierTo(
        center.dx + points[i - 1].dx,
        center.dy + points[i - 1].dy,
        center.dx + points[i].dx,
        center.dy + points[i].dy,
      );
    }
    path.close();
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.deepPurpleAccent.withOpacity(0.8)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_) => true;
}
