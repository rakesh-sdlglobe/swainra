import 'package:flutter/material.dart';

class SwainraScaleOnTapButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const SwainraScaleOnTapButton({super.key, required this.child, required this.onTap});

  @override
  State<SwainraScaleOnTapButton> createState() => _SwainraScaleOnTapButtonState();
}

class _SwainraScaleOnTapButtonState extends State<SwainraScaleOnTapButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
    );
    _scaleAnim = _controller.drive(Tween(begin: 1.0, end: 0.95));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) {
        _controller.forward();
        widget.onTap();
      },
      onTapCancel: () => _controller.forward(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (_, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() => _controller.dispose();
}
