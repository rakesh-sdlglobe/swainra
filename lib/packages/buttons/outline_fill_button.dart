import 'package:flutter/material.dart';

class SwainraOutlineFillButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const SwainraOutlineFillButton({super.key, required this.text, required this.onTap});

  @override
  State<SwainraOutlineFillButton> createState() => _SwainraOutlineFillButtonState();
}

class _SwainraOutlineFillButtonState extends State<SwainraOutlineFillButton> {
  bool _filled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        setState(() => _filled = !_filled);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: _filled ? Colors.black : Colors.transparent,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: _filled ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
