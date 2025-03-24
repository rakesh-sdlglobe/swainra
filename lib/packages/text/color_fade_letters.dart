import 'package:flutter/material.dart';

class SwainraColorFadeLetters extends StatefulWidget {
  final String text;
  final TextStyle style;

  const SwainraColorFadeLetters({super.key, required this.text, required this.style});

  @override
  State<SwainraColorFadeLetters> createState() => _SwainraColorFadeLettersState();
}

class _SwainraColorFadeLettersState extends State<SwainraColorFadeLetters>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = [];

  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  @override
  void initState() {
    for (int i = 0; i < widget.text.length; i++) {
      final c = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      )..repeat(reverse: true);
      _controllers.add(c);
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
    final chars = widget.text.characters.toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(chars.length, (i) {
        final animation = ColorTween(
          begin: _colors[i % _colors.length],
          end: _colors.reversed.toList()[i % _colors.length],
        ).animate(_controllers[i]);

        return AnimatedBuilder(
          animation: animation,
          builder: (_, __) => Text(
            chars[i],
            style: widget.style.copyWith(color: animation.value),
          ),
        );
      }),
    );
  }
}
