import 'package:flutter/material.dart';

class SwainraZoomSpinText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const SwainraZoomSpinText({super.key, required this.text, required this.style});

  @override
  State<SwainraZoomSpinText> createState() => _SwainraZoomSpinTextState();
}

class _SwainraZoomSpinTextState extends State<SwainraZoomSpinText>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = [];

  @override
  void initState() {
    for (int i = 0; i < widget.text.length; i++) {
      final c = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      );
      _controllers.add(c);
      Future.delayed(Duration(milliseconds: i * 100), () => c.forward());
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
        final animation = CurvedAnimation(
            parent: _controllers[i], curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: animation,
          child: RotationTransition(
            turns: animation,
            child: Text(chars[i], style: widget.style),
          ),
        );
      }),
    );
  }
}
