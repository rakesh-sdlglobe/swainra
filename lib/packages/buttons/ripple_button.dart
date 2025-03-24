import 'package:flutter/material.dart';

class SwainraRippleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color splashColor;
  final BorderRadius? borderRadius;
  final EdgeInsets padding;

  const SwainraRippleButton({
    super.key,
    required this.child,
    required this.onTap,
    this.splashColor = Colors.blueAccent,
    this.borderRadius,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        splashColor: splashColor,
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
