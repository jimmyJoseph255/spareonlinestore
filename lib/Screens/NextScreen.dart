import 'package:flutter/material.dart';
import 'package:myproject/Screens/AirtelMoneyScreen.dart';
import 'package:myproject/Screens/DateSelectionScreen.dart';
import 'package:myproject/Screens/HaloPesaScreen.dart';
import 'package:myproject/Screens/TigoPesaScreen.dart';
import 'package:myproject/Screens/MpesaScreen.dart';
import 'PaymentSelectionScreen.dart'; // Import PaymentSelectionScreen

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
            // When user presses back, navigate to the PaymentSelectionScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentSelectionScreen(
                        paymentMethod:
                            'Selected Payment', // Set the payment method appropriately
                        paymentIcon: Icons.payment, // Use an appropriate icon
                      )),
            );
          },
        ),
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // M-PESA Card
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MpesaScreen()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFFD2393D),
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
                      // AIRTEL MONEY Card
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AirtelMoneyScreen()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFFD2393D),
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
                      // TIGO PESA Card
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TigoPesaScreen()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFF005A9E),
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
                      // HALOPESA Card
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HaloPesaScreen()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFFFF6666),
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
