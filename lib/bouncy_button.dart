import 'package:flutter/material.dart';

class BouncyButton extends StatefulWidget {
  @override
  _BouncyButtonState createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: GestureDetector(
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                child: Transform.scale(
                  scale: _scale,
                  child: _animatedButtonUI,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 90,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 30.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFfcba03),
                Color(0xFF2300a1),
              ],
            )),
        child: Center(
          child: Text(
            'TAP',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
