import 'package:flutter/material.dart';
import 'package:swainra/packages/text/liquid_wave_text.dart';
import 'package:swainra/screens/home_screen.dart';
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
      // home: const HomeScreen(),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              SwainraElasticSlideCard(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Elastic Slide Card',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SwainraGlowPulseCard(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Glow Pulse Card',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SwainraNeumorphicCard(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text(
                      'Neumorphic Card',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SwainraFlipCard(
                front: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.orange,
                  child: const Center(
                    child: Text(
                      'Front Side',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                back: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.red,
                  child: const Center(
                    child: Text(
                      'Back Side',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SwainraMagneticHoverCard(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'MagneticHoverCard',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SwainraPaintDropCard(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.pink,
                  child: const Center(
                    child: Text(
                      'PaintDropCard',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SwainraGlassMorphCard(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'GlassMorphCard',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SwainraWaveRevealCard(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.cyanAccent,
                  child: const Center(
                    child: Text(
                      'WaveRevealCard',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SwainraGlowScaleCard(
                glowColor: Colors.deepPurpleAccent,
                child: SizedBox(
                  width: 250,
                  height: 150,
                  child: Center(
                    child: Text(
                      'Swainra 💫',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
