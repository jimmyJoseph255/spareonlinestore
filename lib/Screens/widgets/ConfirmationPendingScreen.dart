import 'package:flutter/material.dart';

class ConfirmationPendingScreen extends StatelessWidget {
  const ConfirmationPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Confirmation Pending',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.access_time,
              color: Colors.orange,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
