import 'package:flutter/material.dart';

class SwainraRotateOnPressButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const SwainraRotateOnPressButton({super.key, required this.onTap, required this.child});

  @override
  State<SwainraRotateOnPressButton> createState() => _SwainraRotateOnPressButtonState();
}

class _SwainraRotateOnPressButtonState extends State<SwainraRotateOnPressButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  void _handleTap() {
    _controller.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 0.25).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() => _controller.dispose();
}
