import 'package:flutter/material.dart';
import 'dart:math';

class SwainraAuroraPulse extends StatefulWidget {
  final double size;

  const SwainraAuroraPulse({super.key, this.size = 100});

  @override
  State<SwainraAuroraPulse> createState() => _SwainraAuroraPulseState();
}

class _SwainraAuroraPulseState extends State<SwainraAuroraPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _wave;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _wave = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Shader _createGradient(Rect rect) {
    return const LinearGradient(
      colors: [Colors.purple, Colors.teal, Colors.blueAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(rect);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _wave,
      builder: (_, __) {
        return CustomPaint(
          painter: _AuroraPainter(_wave.value, _createGradient),
          size: Size.square(widget.size),
        );
      },
    );
  }
}

class _AuroraPainter extends CustomPainter {
  final double scale;
  final Shader Function(Rect rect) shaderBuilder;

  _AuroraPainter(this.scale, this.shaderBuilder);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = shaderBuilder(rect)
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = size.height / 2 * scale;
    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x += 1) {
      path.lineTo(
        x,
        size.height / 2 + sin(x / 15 + scale * 5) * waveHeight,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_AuroraPainter oldDelegate) =>
      oldDelegate.scale != scale;
}
