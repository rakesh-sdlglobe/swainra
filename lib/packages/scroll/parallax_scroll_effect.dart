import 'package:flutter/material.dart';

class SwainraParallaxScrollEffect extends StatelessWidget {
  final List<String> images;
  const SwainraParallaxScrollEffect({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ParallaxImageItem(image: images[index]);
      },
    );
  }
}

class ParallaxImageItem extends StatelessWidget {
  final String image;

  const ParallaxImageItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) => true,
            child: Stack(
              children: [
                Positioned.fill(
                  child: FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 1.5,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: const Text(
                      "Parallax Image",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
