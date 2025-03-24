import 'package:flutter/material.dart';

class SwainraParallaxSlideScroll extends StatelessWidget {
  final List<String> images;
  final List<String> titles;

  const SwainraParallaxSlideScroll({super.key, required this.images, required this.titles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ParallaxItem(
          image: images[index],
          title: titles[index],
        );
      },
    );
  }
}

class ParallaxItem extends StatelessWidget {
  final String image;
  final String title;

  const ParallaxItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
