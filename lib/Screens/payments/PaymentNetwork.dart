import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/payments/AirtelMoneyScreen.dart';

import 'package:myproject/Screens/widgets/DateSelectionScreen.dart';
import 'package:myproject/Screens/payments/HaloPesaScreen.dart';
import 'package:myproject/Screens/payments/MpesaScreen.dart';
import 'package:myproject/Screens/payments/TigoPesaScreen.dart';

import 'PaymentSelectionScreen.dart'; // Import PaymentSelectionScreen

class Paymentnetwork extends StatelessWidget {
  final String paymentMethod;
  final IconData paymentIcon;

  const Paymentnetwork(
      {super.key, required this.paymentMethod, required this.paymentIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Your Network",
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        leading: GestureDetector(
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
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
      ),
      backgroundColor: const Color.fromARGB(
          255, 67, 164, 243), // Set the background color to white
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
                                builder: (context) => MpesaScreen(
                                      paymentMethod: '',
                                      paymentIcon: Icons.payment,
                                    )),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFFD2393D),
                          child: SizedBox(
                            width: 160,
                            height: 100,
                            child: Center(
                              child: Text(
                                'M-PESA',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
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
                                builder: (context) => AirtelMoneyScreen(
                                      paymentMethod: '',
                                      paymentIcon: Icons.payment,
                                    )),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFFD2393D),
                          child: SizedBox(
                            width: 160,
                            height: 100,
                            child: Center(
                              child: Text(
                                'AIRTEL MONEY',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
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
                                builder: (context) => TigoPesaScreen(
                                      paymentMethod: '',
                                      paymentIcon: Icons.payment,
                                    )),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFF005A9E),
                          child: SizedBox(
                            width: 160,
                            height: 100,
                            child: Center(
                              child: Text(
                                'TIGO PESA',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
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
                                builder: (context) => HaloPesaScreen(
                                      paymentMethod: '',
                                      paymentIcon: Icons.payment,
                                    )),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFFFF6666),
                          child: SizedBox(
                            width: 160,
                            height: 100,
                            child: Center(
                              child: Text(
                                'HALOPESA',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
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
