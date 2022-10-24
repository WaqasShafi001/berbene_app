import 'package:flutter/material.dart';

import 'animatedShadow.dart';

class CustomLoadingForBerbene extends StatefulWidget {
  const CustomLoadingForBerbene({Key? key}) : super(key: key);

  @override
  _CustomLoadingForBerbeneState createState() =>
      _CustomLoadingForBerbeneState();
}

class CustomCurve extends CurveTween {
  CustomCurve() : super(curve: Curves.easeInOut);
  @override
  double transform(double t) {
    return (super.transform(t) - 0.5) * 25.0;
  }
}

class _CustomLoadingForBerbeneState extends State<CustomLoadingForBerbene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CustomCurve().animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat(reverse: true);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.2,
            child: ImageTransition(
              'assets/logo.png',
              shadowXOffset: _animation,
            ),
          ),
        ),
      
    );
  }
}
