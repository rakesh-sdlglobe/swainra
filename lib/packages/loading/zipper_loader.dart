import 'package:flutter/material.dart';

class SwainraZipperLoader extends StatefulWidget {
  const SwainraZipperLoader({super.key});

  @override
  State<SwainraZipperLoader> createState() => _SwainraZipperLoaderState();
}

class _SwainraZipperLoaderState extends State<SwainraZipperLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _zip;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _zip = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
  }

  @override
  void dispose() => _controller.dispose();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 100,
      child: AnimatedBuilder(
        animation: _zip,
        builder: (_, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (i) {
              final progress = (_zip.value - i * 0.15).clamp(0.0, 1.0);
              return Transform.scale(
                scale: progress,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 10,
                  height: 30,
                  color: Colors.primaries[i * 2 % Colors.primaries.length],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
