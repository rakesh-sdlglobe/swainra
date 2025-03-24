import 'package:flutter/material.dart';

class FloatingShadowButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const FloatingShadowButton({super.key, required this.text, required this.onTap});

  @override
  State<FloatingShadowButton> createState() => _FloatingShadowButtonState();
}

class _FloatingShadowButtonState extends State<FloatingShadowButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => setState(() => _pressed = true),
      onPointerUp: (_) => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _pressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 6),
                  ),
                ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        child: Text(widget.text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
