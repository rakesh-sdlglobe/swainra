import 'package:flutter/material.dart';

class SwainraGlowingAvatar extends StatefulWidget {
  final String imagePath;
  final double radius;

  const SwainraGlowingAvatar({super.key, required this.imagePath, this.radius = 40});

  @override
  State<SwainraGlowingAvatar> createState() => _SwainraGlowingAvatarState();
}

class _SwainraGlowingAvatarState extends State<SwainraGlowingAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glow = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.6),
              blurRadius: 20 * _glow.value,
              spreadRadius: 2 * _glow.value,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: widget.radius,
          backgroundImage: AssetImage(widget.imagePath),
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
