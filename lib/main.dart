import 'package:flutter/material.dart';
import 'package:swainra/swainra.dart';

void main() => runApp(const SwainraExampleApp());

class SwainraExampleApp extends StatelessWidget {
  const SwainraExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swainra Animation Demo',
      theme: ThemeData(useMaterial3: true),
      home: const AnimationHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnimationHomePage extends StatelessWidget {
  const AnimationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swainra Animations')),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwainraLongPressProgressButton(
                onComplete: () => print('Long Press Complete!'),
                label: 'Long Press',
              ),
              const SizedBox(height: 10),
              SwainraRotateOnPressButton(
                onTap: () => print('Rotate Button Tapped!'),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Rotate',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              SwainraOutlineFillButton(
                text: 'Outline Fill',
                onTap: () => print('Outline Fill Button Tapped!'),
              ),
              const SizedBox(height: 10),
              SwainraCircularRevealButton(
                text: 'Circular Reveal',
                onTap: () => print('Circular Reveal Button Tapped!'),
              ),
              const SizedBox(height: 10),
              SwainraShineEffectButton(
                label: 'Shine Effect',
                onTap: () => print('Shine Effect Button Tapped!'),
              ),
              const SizedBox(height: 10),
              SwainraColorMorphButton(
                label: 'Color Morph',
                onTap: () => print('Color Morph Button Tapped!'),
              ),
              const SizedBox(height: 10),
              SwainraScaleOnTapButton(
                onTap: () => print('Scale On Tap Button Tapped!'),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Scale On Tap',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              SwainraAnimatedButton(
                onTap: () => print('Animated Button Tapped!'),
                child: const Text('Animated Button',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              SwainraSwapButton(
                onSwap: () => print('Swap Button Tapped!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
