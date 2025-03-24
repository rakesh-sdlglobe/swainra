import 'dart:math';
import 'package:flutter/material.dart';

class SwainraOrbitLoader extends StatefulWidget {
  final double size;
  final int orbitCount;
  final Duration duration;

  const SwainraOrbitLoader({
    super.key,
    this.size = 100,
    this.orbitCount = 3,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<SwainraOrbitLoader> createState() => _SwainraOrbitLoaderState();
}

class _SwainraOrbitLoaderState extends State<SwainraOrbitLoader> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.orbitCount, (index) {
      final controller = AnimationController(
        vsync: this,
        duration: widget.duration * (index + 1),
      )..repeat();
      return controller;
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(widget.orbitCount, (index) {
          final radius = widget.size / 4 + index * 10.0;
          return AnimatedBuilder(
            animation: _controllers[index],
            builder: (_, __) {
              final angle = _controllers[index].value * 2 * pi;
              return Transform.translate(
                offset: Offset(cos(angle) * radius, sin(angle) * radius),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.accents[index * 2 % Colors.accents.length],
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
