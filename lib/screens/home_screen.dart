import 'package:flutter/material.dart';
import 'package:swainra/packages/navigation/page_transitions.dart';
import 'second_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildButton(BuildContext context,
      {required String label, required Route<Object?> Function() routeBuilder}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () {
            Navigator.of(context).push(routeBuilder());
          },
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swainra Animation Demo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                context,
                label: 'Slide Left',
                routeBuilder: () => SwainraPageTransitions.swainraSlideLeftRoute(const SecondScreen()),
              ),
              _buildButton(
                context,
                label: 'Fade',
                routeBuilder: () => SwainraPageTransitions.swainraFadeRoute(const SecondScreen()),
              ),
              _buildButton(
                context,
                label: 'Scale',
                routeBuilder: () => SwainraPageTransitions.swainraScaleRoute(const SecondScreen()),
              ),
              _buildButton(
                context,
                label: 'Rotate',
                routeBuilder: () => SwainraPageTransitions.swainraRotateRoute(const SecondScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
