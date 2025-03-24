import 'package:flutter/material.dart';

class SwainraColorMorphButton extends StatefulWidget {
  final VoidCallback onTap;
  final String label;

  const SwainraColorMorphButton({super.key, required this.onTap, required this.label});

  @override
  State<SwainraColorMorphButton> createState() => _SwainraColorMorphButtonState();
}

class _SwainraColorMorphButtonState extends State<SwainraColorMorphButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _pressed ? Colors.blueAccent : Colors.purple,
        ),
        child: Text(widget.label, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
