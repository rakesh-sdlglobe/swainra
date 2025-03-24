import 'dart:math';
import 'package:flutter/material.dart';

class SwainraShrinkGlowScroll extends StatefulWidget {
  final List<Widget> children;
  const SwainraShrinkGlowScroll({super.key, required this.children});

  @override
  State<SwainraShrinkGlowScroll> createState() => _SwainraShrinkGlowScrollState();
}

class _SwainraShrinkGlowScrollState extends State<SwainraShrinkGlowScroll> {
  final ScrollController _controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        offset = _controller.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      controller: _controller,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        final itemOffset = index * 140.0;
        final center = offset + screenHeight / 2;
        final dist = (itemOffset - center).abs();
        final scale = (1 - (dist / screenHeight)).clamp(0.9, 1.0);
        final glow = (10 * (1 - dist / screenHeight).clamp(0, 1)) as double;

        return Transform.scale(
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.4),
                  blurRadius: glow,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: widget.children[index],
          ),
        );
      },
    );
  }
}
