import 'package:flutter/material.dart';

class SwainraSlideFadeTransition extends StatelessWidget {
  final Widget child;
  final Animation<Offset> position;
  final Animation<double> opacity;

  const SwainraSlideFadeTransition({Key? key, required this.child, required this.position, required this.opacity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: FadeTransition(
        opacity: opacity,
        child: child,
      ),
    );
  }
}
