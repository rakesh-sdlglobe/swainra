import 'package:flutter/material.dart';

class SwainraNeumorphicCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double padding;
  final Color? color;

  const SwainraNeumorphicCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.padding = 16.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = color ?? Theme.of(context).scaffoldBackgroundColor;
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            offset: Offset(-6, -6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: Color(0xFFBEBEBE),
            offset: Offset(6, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: child,
    );
  }
}
