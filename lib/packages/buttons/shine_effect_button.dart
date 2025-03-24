import 'package:flutter/material.dart';
import 'package:swainra/packages/effects/shimmer_loader.dart';

class SwainraShineEffectButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const SwainraShineEffectButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const Positioned.fill(
            child:SwainraShimmerLoader(), // You can define your shimmer effect here
          )
        ],
      ),
    );
  }
}
