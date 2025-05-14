import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/widgets/startscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _carController;
  late Animation<double> _carMoveAnimation;
  late AnimationController _wheelController;

  @override
  void initState() {
    super.initState();

    // Car Animation Controller
    _carController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Car movement speed
    );

    // Car Move Animation (Enter from right)
    _carMoveAnimation = Tween<double>(begin: 1.5, end: 0).animate(
      CurvedAnimation(parent: _carController, curve: Curves.easeOutExpo),
    );

    // Wheel Rotation Animation
    _wheelController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Speed of rotation
    )..repeat(); // Wheels keep spinning

    // Start animations
    _carController.forward();

    // Navigate to Dashboard after 4 seconds
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Start()),
      );
    });
  }

  @override
  void dispose() {
    _carController.dispose();
    _wheelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0072FF), Color(0xFF16AFDA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Title with Fade-in Effect
          Positioned(
            top: 100,
            child: TweenAnimationBuilder(
              duration: Duration(seconds: 2),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    "Spare Faster",
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                );
              },
            ),
          ),

          // Animated Car with Wheels Spinning
          AnimatedBuilder(
            animation: _carController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  _carMoveAnimation.value * MediaQuery.of(context).size.width,
                  0,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Car Body
                    Image.asset(
                      'lib/images/splash.png',
                      width: 300,
                      height: 200,
                    ),
                  ],
                ),
              );
            },
          ),

          // "Loading..." Text
          Positioned(
            bottom: 80,
            child: TweenAnimationBuilder(
              duration: Duration(seconds: 3),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    "Loading...",
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 20,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          // Progress Indicator
          Positioned(
            bottom: 50,
            child: SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white38,
                color: Colors.white,
                minHeight: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
