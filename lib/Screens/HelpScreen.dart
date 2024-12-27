import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: Colors.white, // AppBar color set to white
        iconTheme:
            const IconThemeData(color: Colors.black), // Icon color set to black
      ),
      body: const Center(
        child: Text(
          'Welcome to the Help Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white, // Set the body background color to white
    );
  }
}
