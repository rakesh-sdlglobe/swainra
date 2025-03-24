import 'package:flutter/material.dart';

class SwainraAnimatedCounter extends StatelessWidget {
  final int count;
  final TextStyle? style;
  final Duration duration;

  const SwainraAnimatedCounter({
    Key? key,
    required this.count,
    this.style,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: count),
      duration: duration,
      builder: (context, value, child) {
        return Text(
          value.toString(),
          style: style ?? Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}
