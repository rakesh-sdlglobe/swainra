import 'package:flutter/material.dart';

class SwainraAnimatedToggle extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onToggle;

  const SwainraAnimatedToggle({super.key, required this.initialValue, required this.onToggle});

  @override
  State<SwainraAnimatedToggle> createState() => _SwainraAnimatedToggleState();
}

class _SwainraAnimatedToggleState extends State<SwainraAnimatedToggle> with SingleTickerProviderStateMixin {
  late bool isToggled;
  late AnimationController _controller;
  late Animation<Alignment> _circleAnimation;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _circleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(_controller);

    if (isToggled) {
      _controller.forward();
    }
  }

  void toggleButton() {
    if (isToggled) {
      _controller.reverse();
    } else {
      _controller.forward();
    }

    setState(() {
      isToggled = !isToggled;
    });
    widget.onToggle(isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleButton,
      child: Container(
        width: 60,
        height: 30,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isToggled ? Colors.green : Colors.grey[400],
        ),
        child: Align(
          alignment: _circleAnimation.value,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
