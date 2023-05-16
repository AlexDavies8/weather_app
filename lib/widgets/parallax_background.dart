import 'package:flutter/material.dart';
import 'package:weather_app/widgets/parallax_camera.dart';
import 'package:weather_app/widgets/parallax_element.dart';

class ParallaxBackground extends StatefulWidget {
  final double offset;

  const ParallaxBackground({super.key, required this.offset});

  @override
  State<StatefulWidget> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground> with SingleTickerProviderStateMixin {
  
  late Animation<double> animation;
  late AnimationController animController;
  
  @override
  void initState() {
    super.initState();

    animController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
  
    animation = Tween(begin: 1.0, end: 0.0)
      .animate(CurvedAnimation(parent: animController, curve: Curves.easeInOutCubic))
      ..addListener(() {
        setState(() {});
      });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ParallaxCamera(
      depth: -10,
      y: -widget.offset,
      child: Stack(
        children: [
          ParallaxElement(depth: 10000, expand: true, child: Container(color: Color.fromARGB(255, 138, 181, 180))),
          ParallaxElement(depth: 100, child: Image.asset("assets/images/Layer4.png", fit: BoxFit.cover, color: Color.fromARGB(255, 237, 241, 214))),
          ParallaxElement(depth: 50, child: Image.asset("assets/images/Layer3.png", fit: BoxFit.cover, color: Color.fromARGB(255, 157, 192, 139))),
          ParallaxElement(depth: 15, child: Image.asset("assets/images/Layer2.png", fit: BoxFit.cover, color: Color.fromARGB(255, 96, 153, 102))),
          ParallaxElement(depth: 5, child: Image.asset("assets/images/Layer1.png", fit: BoxFit.cover, color: Color.fromARGB(255, 64, 81, 59))),
          ParallaxElement(depth: 5, expand: true, yOffset: 1199, child: Container(color: Color.fromARGB(255, 64, 81, 59))),
        ],
      )
    ) ;
  }
}