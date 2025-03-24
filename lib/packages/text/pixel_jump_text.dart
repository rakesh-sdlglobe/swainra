import 'package:flutter/material.dart';

class SwainraPixelJumpText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const SwainraPixelJumpText({super.key, required this.text, required this.style});

  @override
  State<SwainraPixelJumpText> createState() => _SwainraPixelJumpTextState();
}

class _SwainraPixelJumpTextState extends State<SwainraPixelJumpText>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers = [];

  @override
  void initState() {
    for (int i = 0; i < widget.text.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      )..repeat(reverse: true);
      _controllers.add(controller);
    }

    super.initState();
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.text.characters.toList().asMap().entries.map((entry) {
        final i = entry.key;
        final char = entry.value;

        return AnimatedBuilder(
          animation: _controllers[i],
          builder: (_, __) {
            final offset = -2.0 * (i % 2 == 0 ? 1 : -1) *
                (0.5 - (_controllers[i].value - 0.5).abs());

            return Transform.translate(
              offset: Offset(0, offset * 8),
              child: Text(char, style: widget.style),
            );
          },
        );
      }).toList(),
    );
  }
}
