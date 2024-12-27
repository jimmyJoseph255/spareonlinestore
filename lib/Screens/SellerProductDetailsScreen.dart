import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productName;

  const ProductDetailsScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the AppBar background to white
        title: Text(
          productName,
          style: TextStyle(
              color: Colors.black), // Set the title text color to black
        ),
        elevation: 0, // Remove shadow under the AppBar
      ),
      backgroundColor: Colors.white, // Set the screen background to white
      body: Center(
        child: Text(
          'Details of $productName will be displayed here.',
          style: TextStyle(
              fontSize: 18, color: Colors.black), // Set text color to black
        ),
      ),
    );
  }
}
