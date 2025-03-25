import 'package:flutter/material.dart';
import 'package:swainra/swainra.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeController.loadTheme();
  runApp(const SwainraExampleApp());
}

class SwainraExampleApp extends StatelessWidget {
  const SwainraExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: ThemeController.themeNotifier,
      builder: (_, theme, __) {
        return MaterialApp(
          title: 'Swainra Animation Demo',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const AnimationHomePage(),
        );
      },
    );
  }
}

class AnimationHomePage extends StatelessWidget {
  const AnimationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Swainra Animations'), actions: [
        IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          onPressed: ThemeController.toggleTheme,
        )
      ]),
      body: const Padding(
        padding: EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Swainra World!",
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "Neumorphic Card, Neumorphic Card, Neumorphic Card,Neumorphic Card,Neumorphic Card,Neumorphic Card,")),
              ),
              SizedBox(height: 20),
              SwainraRichTextAnimator(
                "This is <b>bold</b>, <i>italic</i>, <u>underline</u>, <g>gradient</g> and <c color='#e91e63'>pink</c> text.\nYou can <size=40>also</size=40> use **bold** or *italic* with markdown style! ",
                gradient:
                    const LinearGradient(colors: [Colors.teal, Colors.amber]),
                animation: SwainraTextAnimation.slideUp,
              ),
              SizedBox(height: 20),
              SwainraRichTextAnimator(
                "This is a <b>bold</b> word and a <link url='https://flutter.dev'>link</link> to Flutter's website.",
                animation: SwainraTextAnimation.fadeIn,
                gradient: LinearGradient(colors: [Colors.orange, Colors.pink]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
