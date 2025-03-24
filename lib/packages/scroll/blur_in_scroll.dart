import 'dart:ui';
import 'package:flutter/material.dart';

class SwainraBlurInScroll extends StatefulWidget {
  final List<Widget> children;
  const SwainraBlurInScroll({super.key, required this.children});

  @override
  State<SwainraBlurInScroll> createState() => _SwainraBlurInScrollState();
}

class _SwainraBlurInScrollState extends State<SwainraBlurInScroll> {
  final ScrollController _scrollController = ScrollController();
  double _scrollY = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        _scrollY = _scrollController.offset;
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
        double itemPosition = index * 100.0;
        double diff = (_scrollY - itemPosition).abs();
        double blurAmount = (diff < 150) ? (150 - diff) / 20 : 0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Stack(
            children: [
              widget.children[index],
              if (blurAmount > 0)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
                    child: Container(color: Colors.transparent),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
