import 'package:flutter/material.dart';
import 'package:weather_app/widgets/parallax_camera.dart';

/// A class representing a widget that can be rendered with a parallax effect
class ParallaxElement extends StatelessWidget {
  final Widget child;
  final double depth;
  final bool expandWidth;
  final bool expandHeight;
  final double xOffset;
  final double yOffset;

  const ParallaxElement(
      {super.key,
      required this.child,
      this.depth = 0.0,
      this.expandWidth = true,
      this.expandHeight = false,
      this.xOffset = 0,
      this.yOffset = 0});

  @override
  Widget build(BuildContext context) {
    final camera = ParallaxCamera.of(context);
    final d1 = depth;
    final d2 = depth - camera.depth;
    final dz = 1 - d1 / d2;
    final x = dz * camera.x + xOffset;

    final screenHeight = MediaQuery.of(context).size.width;
    final scaleFactor = screenHeight / 600;
    final adjustedYOffset = yOffset * scaleFactor;
    final y = dz * camera.y + adjustedYOffset;
    return Positioned(
        left: x,
        top: y,
        right: expandWidth ? 0 : null,
        bottom: expandHeight ? 0 : null,
        child: child);
  }
}
