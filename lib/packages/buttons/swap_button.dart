// widgets/swap_button.dart
import 'package:flutter/material.dart';

class SwainraSwapButton extends StatefulWidget {
  final VoidCallback onSwap;

  const SwainraSwapButton({super.key, required this.onSwap});

  @override
  State<SwainraSwapButton> createState() => _SwainraSwapButtonState();
}

class _SwainraSwapButtonState extends State<SwainraSwapButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _rotation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _handleTap() {
    _controller.forward(from: 0);
    widget.onSwap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: RotationTransition(
        turns: _rotation,
        child: const Icon(Icons.swap_vert, size: 36, color: Colors.deepPurple),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
