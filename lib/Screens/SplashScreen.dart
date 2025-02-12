import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/Dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Start()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set blue background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row for "Spare Store" text and the delivery icon
            Row(
              mainAxisSize:
                  MainAxisSize.min, // Make the row take only the space it needs
              children: [
                Text(
                  'Spare Store',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text on blue background
                  ),
                ),
                SizedBox(width: 10),
                Stack(
                  alignment: Alignment
                      .bottomCenter, // Align the location icon above the delivery icon
                  children: [
                    Icon(
                      Icons.delivery_dining_outlined, // Delivery icon
                      size: 50,
                      color: Colors.white,
                    ),
                    Positioned(
                      top: -10,
                      child: Icon(
                        Icons
                            .location_on, // Location icon above the delivery icon
                        size: 20,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
