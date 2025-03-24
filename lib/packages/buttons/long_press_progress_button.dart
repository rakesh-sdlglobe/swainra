import 'package:flutter/material.dart';
import 'dart:async';

class SwainraLongPressProgressButton extends StatefulWidget {
  final VoidCallback onComplete;
  final String label;
  final Duration duration;
  final Color progressColor;
  final Color backgroundColor;
  final TextStyle labelStyle;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SwainraLongPressProgressButton({
    super.key,
    required this.onComplete,
    required this.label,
    this.duration = const Duration(seconds: 2),
    this.progressColor = Colors.deepOrange,
    this.backgroundColor = Colors.grey,
    this.labelStyle = const TextStyle(color: Colors.white, fontSize: 16),
    this.width = 200,
    this.height = 50,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  State<SwainraLongPressProgressButton> createState() => _SwainraLongPressProgressButtonState();
}

class _SwainraLongPressProgressButtonState extends State<SwainraLongPressProgressButton> {
  double _progress = 0.0;
  Timer? _timer;

  void _startTimer() {
    setState(() => _progress = 0.0);
    final totalMilliseconds = widget.duration.inMilliseconds;
    final increment = 50; // Update every 50 milliseconds
    final progressIncrement = increment / totalMilliseconds;

    _timer = Timer.periodic(Duration(milliseconds: increment), (timer) {
      setState(() => _progress += progressIncrement);
      if (_progress >= 1.0) {
        timer.cancel();
        widget.onComplete();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() => _progress = 0.0);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => _startTimer(),
      onLongPressEnd: (_) => _stopTimer(),
      onLongPressCancel: () => _stopTimer(),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: widget.borderRadius,
            ),
            child: Center(
              child: Text(
                widget.label,
                style: widget.labelStyle,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: widget.width * _progress,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.progressColor,
              borderRadius: widget.borderRadius,
            ),
          ),
        ],
      ),
    );
  }
}
