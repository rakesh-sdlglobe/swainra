import 'package:flutter/material.dart';

class SwainraPulseGlow extends StatefulWidget {
  final Widget child;
  const SwainraPulseGlow({super.key, required this.child});

  @override
  State<SwainraPulseGlow> createState() => _SwainraPulseGlowState();
}

class _SwainraPulseGlowState extends State<SwainraPulseGlow> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat(reverse: true);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.4 * _controller.value),
              blurRadius: 12 * _controller.value,
              spreadRadius: 2,
            )
          ]),
          child: child,
        );
      },
    );
  }
}
