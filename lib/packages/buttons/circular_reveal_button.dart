import 'package:flutter/material.dart';

class SwainraCircularRevealButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SwainraCircularRevealButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        splashColor: Colors.white.withOpacity(0.3),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
