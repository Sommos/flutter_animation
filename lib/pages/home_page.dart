import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    super.initState();

    // animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // rotation animation
    _rotationAnimation = Tween(
      begin: 0.0, 
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOut
    ),);

    // radius animation -> from circle to square
    _radiusAnimation = Tween(
      begin: 450.0, 
      end: 10.0
    ).animate(CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOut
    ));

    _controller.addListener(() {
      setState(() {});
    });

    // make animation go back and forth
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    // build function to build each object
    buildTransformObject(value, width, height, color) {
      return
      Transform.rotate(
        angle: _rotationAnimation.value + value,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(_radiusAnimation.value),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            /* 
            biggest object
            | 
            V
            smallest object
            */

            // first, biggest object
            buildTransformObject(0.0, 225.0, 225.0, Colors.deepPurple[400]),

            // second object
            buildTransformObject(0.2, 200.0, 200.0, Colors.deepPurple[500]),

            // third object
            buildTransformObject(0.4, 175.0, 175.0, Colors.deepPurple[600]),   

            // fourth object
            buildTransformObject(0.6, 150.0, 150.0, Colors.deepPurple[700]),

            // fifth object
            buildTransformObject(0.8, 125.0, 125.0, Colors.deepPurple[800]),

            // sixth object
            buildTransformObject(1.0, 100.0, 100.0, Colors.deepPurple[900]),

            // seventh object
            buildTransformObject(1.2, 75.0, 75.0, Colors.deepPurple[1000]),

            // eighth object
            buildTransformObject(1.4, 50.0, 50.0, Colors.deepPurple[1100]),

            // last, smallest object
            buildTransformObject(1.6, 25.0, 25.0, Colors.deepPurple[1200]),
          ],
        ),
      ),
    );
  }
}