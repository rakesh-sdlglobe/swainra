import 'package:flutter/material.dart';

class SwainraFadeInOnScroll extends StatefulWidget {
  final List<Widget> children;
  const SwainraFadeInOnScroll({super.key, required this.children});

  @override
  State<SwainraFadeInOnScroll> createState() => _SwainraFadeInOnScrollState();
}

class _SwainraFadeInOnScrollState extends State<SwainraFadeInOnScroll> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        double opacity = (_scrollOffset > (index * 100)) ? 1.0 : 0.0;
        return AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 600),
          child: widget.children[index],
        );
      },
    );
  }
}
