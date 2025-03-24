import 'package:flutter/material.dart';

class SwainraGlowScaleCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color glowColor;
  final double borderRadius;
  final double scaleOnTap;

  const SwainraGlowScaleCard({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.glowColor = Colors.cyanAccent,
    this.borderRadius = 20,
    this.scaleOnTap = 0.97,
  });

  @override
  State<SwainraGlowScaleCard> createState() => _SwainraGlowScaleCardState();
}

class _SwainraGlowScaleCardState extends State<SwainraGlowScaleCard>
    with TickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final AnimationController _glowController;

  @override
  void initState() {
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.03,
    );

    _glowController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.0)
          .animate(CurvedAnimation(parent: _glowController, curve: Curves.easeOutBack)),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: () => _scaleController.reverse(),
        child: AnimatedBuilder(
          animation: _scaleController,
          builder: (context, child) {
            final scale = 1 - _scaleController.value;
            return Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: widget.glowColor.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: Material(
                    color: Colors.white,
                    child: widget.child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
