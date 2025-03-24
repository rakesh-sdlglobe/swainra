import 'package:flutter/material.dart';

class SwainraMagicTrailScroll extends StatefulWidget {
  final List<Widget> children;
  const SwainraMagicTrailScroll({super.key, required this.children});

  @override
  State<SwainraMagicTrailScroll> createState() => _SwainraMagicTrailScrollState();
}

class _SwainraMagicTrailScrollState extends State<SwainraMagicTrailScroll> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        final itemOffset = index * 120.0;
        final difference = (_scrollOffset - itemOffset).clamp(-200, 200);
        final opacity = 1.0 - (difference.abs() / 200);
        final translateY = (difference > 0) ? difference / 5.0 : 0.0;

        return Transform.translate(
          offset: Offset(0, translateY),
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: widget.children[index],
            ),
          ),
        );
      },
    );
  }
}
