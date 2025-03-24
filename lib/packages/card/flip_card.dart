import 'package:flutter/material.dart';
import 'dart:math';

class SwainraFlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const SwainraFlipCard({super.key, required this.front, required this.back});

  @override
  State<SwainraFlipCard> createState() => _SwainraFlipCardState();
}

class _SwainraFlipCardState extends State<SwainraFlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          bool isFront = _animation.value < pi / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_animation.value),
            child: isFront ? widget.front : Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: widget.back,
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
