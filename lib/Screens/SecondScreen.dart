import 'package:flutter/material.dart';
import 'CustomerScreen.dart';
import 'SellerLoginPageScreen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set Scaffold background color to white
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spacing
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 200), // Space from the top

                // "Click as Customer" Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to CustomerScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Click as Customer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // "OR" Text
                const Center(
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // "Click as Seller" Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to SellerScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellerLoginPageScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Click as Seller',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Bottom Image and Design
            Container(
              color: Colors.white, // Ensures the bottom background is white
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    'lib/images/img.png', // Replace with your image path
                    width: 300,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
