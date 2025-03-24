import 'package:flutter/material.dart';

class SwainraFadeSlideText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const SwainraFadeSlideText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  State<SwainraFadeSlideText> createState() => _SwainraFadeSlideTextState();
}

class _SwainraFadeSlideTextState extends State<SwainraFadeSlideText>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = [];
  late final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.text.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      final animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      );
      _controllers.add(controller);
      _animations.add(animation);

      Future.delayed(Duration(milliseconds: i * 80), () {
        if (mounted) controller.forward();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.text.length, (i) {
        return FadeTransition(
          opacity: _animations[i],
          child: SlideTransition(
            position: _animations[i].drive(
              Tween<Offset>(begin: const Offset(0, 0.8), end: Offset.zero),
            ),
            child: Text(widget.text[i], style: widget.style),
          ),
        );
      }),
    );
  }
}
