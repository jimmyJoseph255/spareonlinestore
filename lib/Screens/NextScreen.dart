import 'package:flutter/material.dart';
import 'package:myproject/Screens/AirtelMoneyScreen.dart';
import 'package:myproject/Screens/DateSelectionScreen.dart';
import 'package:myproject/Screens/HaloPesaScreen.dart';
import 'package:myproject/Screens/TigoPesaScreen.dart';
import 'package:myproject/Screens/MpesaScreen.dart';

class NextScreen extends StatelessWidget {
  final String paymentMethod;
  final IconData paymentIcon;

  const NextScreen(
      {super.key, required this.paymentMethod, required this.paymentIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Network"),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // When user presses back, they will go back to the PaymentScreen,
            // and the previous selection will be cleared
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DateSelectionScreen()),
            );
          },
        ),
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            // Add space before the cards
            const SizedBox(height: 100), // Add space here

            // Display two rows of cards
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // M-PESA Card with color D2393D
                      GestureDetector(
                        onTap: () {
                          // Navigate to M-PESA Screen when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MpesaScreen()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color:
                              const Color(0xFFD2393D), // Red color for M-PESA
                          child: SizedBox(
                            width: 160,
                            height: 100,
                            child: const Center(
                              child: Text('M-PESA',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      // AIRTEL MONEY Card with color D2393D
                      GestureDetector(
                        onTap: () {
                          // Navigate to AIRTEL MONEY Screen when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AirtelMoneyScreen()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(
                              0xFFD2393D), // Red color for AIRTEL MONEY
                          child: SizedBox(
                            width: 160,
                            height: 100,
                            child: const Center(
                              child: Text('AIRTEL MONEY',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TIGO PESA Card with color 005A9E
                      GestureDetector(
                        onTap: () {
                          // Navigate to TigoPesaScreen when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TigoPesaScreen()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(
                              0xFF005A9E), // Blue color for TIGO PESA
                          child: SizedBox(
                            width: 160,
                            height: 100,
                            child: const Center(
                              child: Text('TIGO PESA',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      // HALOPESA Card with color FF6666
                      GestureDetector(
                        onTap: () {
                          // Navigate to HALOPESA Screen when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HaloPesaScreen()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(
                              0xFFFF6666), // Light Red color for HALOPESA
                          child: SizedBox(
                            width: 160,
                            height: 100,
                            child: const Center(
                              child: Text('HALOPESA',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
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
