import 'package:flutter/material.dart';

class TopBackground extends StatelessWidget {
  const TopBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ShaderMask(   //applies a fading mask
        shaderCallback: (Rect bounds) {   //rectangular area
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FFE5),        // Keep visible on top
              Colors.transparent,  // Fade away at bottom
            ],
            stops: [0.8, 1.0],
          ).createShader(bounds);  //knows how much area to be faded
        },
        blendMode: BlendMode.dstIn,  //Keeps only the parts of the image where the gradient is not transparent
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            image: const DecorationImage(
              image: AssetImage('assets/images/clouds.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
