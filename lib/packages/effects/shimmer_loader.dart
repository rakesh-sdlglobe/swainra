import 'package:flutter/material.dart';

class SwainraShimmerLoader extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SwainraShimmerLoader({
    super.key,
    this.width = double.infinity,
    this.height = 16.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  State<SwainraShimmerLoader> createState() => _SwainraShimmerLoaderState();
}

class _SwainraShimmerLoaderState extends State<SwainraShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: const [0.1, 0.5, 0.9],
              begin: Alignment(-1.0 - _controller.value * 2, 0),
              end: Alignment(1.0 + _controller.value * 2, 0),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: widget.borderRadius,
            ),
          ),
        );
      },
    );
  }
}
