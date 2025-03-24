import 'package:flutter/material.dart';

class SwainraSlideInOnScroll extends StatefulWidget {
  final List<Widget> children;
  const SwainraSlideInOnScroll({super.key, required this.children});

  @override
  State<SwainraSlideInOnScroll> createState() => _SwainraSlideInOnScrollState();
}

class _SwainraSlideInOnScrollState extends State<SwainraSlideInOnScroll> {
  final ScrollController _controller = ScrollController();
  double _offset = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _offset = _controller.offset;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        final slideAmount = (_offset - (index * 100)).clamp(-100.0, 0.0);
        return Transform.translate(
          offset: Offset(slideAmount, 0),
          child: Opacity(
            opacity: (_offset > (index * 80)) ? 1.0 : 0.0,
            child: widget.children[index],
          ),
        );
      },
    );
  }
}
