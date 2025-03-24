import 'package:flutter/material.dart';
import 'dart:math';

class SwainraMagneticHoverCard extends StatefulWidget {
  final Widget child;
  final double maxTilt;
  final double scale;
  final double borderRadius;

  const SwainraMagneticHoverCard({
    super.key,
    required this.child,
    this.maxTilt = 0.15,
    this.scale = 1.05,
    this.borderRadius = 16,
  });

  @override
  State<SwainraMagneticHoverCard> createState() => _SwainraMagneticHoverCardState();
}

class _SwainraMagneticHoverCardState extends State<SwainraMagneticHoverCard> {
  double _tiltX = 0;
  double _tiltY = 0;

  void _onPanUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    final size = constraints.biggest;
    final dx = details.localPosition.dx;
    final dy = details.localPosition.dy;
    final tiltX = (dy - size.height / 2) / (size.height / 2) * widget.maxTilt;
    final tiltY = -(dx - size.width / 2) / (size.width / 2) * widget.maxTilt;

    setState(() {
      _tiltX = tiltX;
      _tiltY = tiltY;
    });
  }

  void _resetTilt() => setState(() {
        _tiltX = 0;
        _tiltY = 0;
      });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => GestureDetector(
        onPanUpdate: (details) => _onPanUpdate(details, constraints),
        onPanEnd: (_) => _resetTilt(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_tiltX)
            ..rotateY(_tiltY)
            ..scale(widget.scale),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
