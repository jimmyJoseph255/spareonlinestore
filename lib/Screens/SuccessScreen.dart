import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: const Text(
          'Success',
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        elevation: 0,
      ),
      body: Center(
        child: Icon(
          Icons.check_circle_outline,
          size: 200,
          color: Colors.white,
        ),
      ),
    );
  }
}
