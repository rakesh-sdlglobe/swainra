// loading/silken_glow.dart
import 'package:flutter/material.dart';

class SwainraSilkenGlow extends StatefulWidget {
  const SwainraSilkenGlow({super.key, this.size = 80});
  final double size;

  @override
  State<SwainraSilkenGlow> createState() => _SwainraSilkenGlowState();
}

class _SwainraSilkenGlowState extends State<SwainraSilkenGlow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glow = Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _glow,
        builder: (context, child) {
          return Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.purpleAccent.withOpacity(_glow.value),
                  Colors.deepPurple.withOpacity(_glow.value * 0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purpleAccent.withOpacity(_glow.value),
                  blurRadius: 20 * _glow.value,
                  spreadRadius: 1,
                ),
              ],
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
