// animations/loading_spinner.dart
import 'package:flutter/material.dart';

class SwainraLoadingSpinner extends StatefulWidget {
  final double size;
  final Color color;

  const SwainraLoadingSpinner({super.key, this.size = 50.0, this.color = Colors.blue});

  @override
  State<SwainraLoadingSpinner> createState() => _SwainraLoadingSpinnerState();
}

class _SwainraLoadingSpinnerState extends State<SwainraLoadingSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _controller,
        child: Icon(Icons.sync, size: widget.size, color: widget.color),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
