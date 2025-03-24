import 'package:flutter/material.dart';

class SwainraDepthZoomScroll extends StatefulWidget {
  final List<String> items;
  final double zoomFactor;
  final double itemHeight;
  final Duration animationDuration;

  const SwainraDepthZoomScroll({
    super.key,
    required this.items,
    this.zoomFactor = 0.2,
    this.itemHeight = 100.0,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  State<SwainraDepthZoomScroll> createState() => _SwainraDepthZoomScrollState();
}

class _SwainraDepthZoomScrollState extends State<SwainraDepthZoomScroll> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {});
  }

  double _getItemScale(int index) {
    final position = _scrollController.offset;
    final itemPosition = index * widget.itemHeight;
    final distance = (position - itemPosition).abs();
    final maxDistance = widget.itemHeight;
    final scaleFactor = 1.0 - (distance / maxDistance) * widget.zoomFactor;
    return scaleFactor.clamp(1.0 - widget.zoomFactor, 1.0);
  }

  double _getItemOpacity(int index) {
    final position = _scrollController.offset;
    final itemPosition = index * widget.itemHeight;
    final distance = (position - itemPosition).abs();
    final maxDistance = widget.itemHeight;
    final opacityFactor = 1.0 - (distance / maxDistance);
    return opacityFactor.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.items.length,
      itemExtent: widget.itemHeight,
      itemBuilder: (context, index) {
        final scale = _getItemScale(index);
        final opacity = _getItemOpacity(index);
        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: Card(
              elevation: 10,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: ListTile(
                title: Text(
                  widget.items[index],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
