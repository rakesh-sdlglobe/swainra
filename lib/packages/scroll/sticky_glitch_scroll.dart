import 'dart:math';
import 'package:flutter/material.dart';

class SwainraStickyGlitchScroll extends StatefulWidget {
  final List<Widget> children;
  const SwainraStickyGlitchScroll({super.key, required this.children});

  @override
  State<SwainraStickyGlitchScroll> createState() => _SwainraStickyGlitchScrollState();
}

class _SwainraStickyGlitchScrollState extends State<SwainraStickyGlitchScroll> {
  final ScrollController _scrollController = ScrollController();
  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
  }

  bool isInCenter(int index, double screenHeight) {
    final itemPosition = index * 140.0;
    final center = scrollOffset + screenHeight / 2;
    return (itemPosition - center).abs() < 80;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        final shouldGlitch = isInCenter(index, screenHeight);
        final random = Random();
        final glitchOffset = shouldGlitch ? Offset(random.nextInt(4) - 2.0, random.nextInt(4) - 2.0) : Offset.zero;
        final glitchColor = shouldGlitch ? Colors.primaries[random.nextInt(Colors.primaries.length)] : Colors.transparent;

        return Transform.translate(
          offset: glitchOffset,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: glitchColor, width: 2),
              borderRadius: BorderRadius.circular(12),
              boxShadow: shouldGlitch
                  ? [BoxShadow(color: glitchColor.withOpacity(0.6), blurRadius: 10)]
                  : [],
            ),
            child: widget.children[index],
          ),
        );
      },
    );
  }
}
