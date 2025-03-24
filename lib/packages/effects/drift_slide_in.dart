import 'package:flutter/material.dart';

class SwainraDriftSlideIn extends StatefulWidget {
  final Widget child;
  const SwainraDriftSlideIn({super.key, required this.child});

  @override
  State<SwainraDriftSlideIn> createState() => _SwainraDriftSlideInState();
}

class _SwainraDriftSlideInState extends State<SwainraDriftSlideIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _offset = Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _offset, child: widget.child);
  }
}
