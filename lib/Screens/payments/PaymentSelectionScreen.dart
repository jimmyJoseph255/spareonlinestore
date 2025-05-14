import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'PaymentNetwork.dart'; // Import the NextScreen

class PaymentSelectionScreen extends StatelessWidget {
  final String paymentMethod;
  final IconData paymentIcon;

  const PaymentSelectionScreen({
    Key? key,
    required this.paymentMethod,
    required this.paymentIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: Text(
          'Payment Method',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text for "Choose Payment Method"
            Text(
              'Choose Payment',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 20),
            // Cash on Delivery option
            ElevatedButton(
              onPressed: () {
                // Show a SnackBar when Cash on Delivery is selected
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cash on Delivery selected!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.yellow,
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.money_off,
                    color: Colors.red,
                  ), // Icon for Cash on Delivery
                  const SizedBox(width: 10), // Space between icon and text
                  Text(
                    'Cash on Delivery',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Mobile Money option
            ElevatedButton(
              onPressed: () {
                // Mobile Money selected, navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paymentnetwork(
                      paymentMethod: 'Mobile Money',
                      paymentIcon: Icons.money, // Example icon
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.yellow,
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.red,
                  ), // Icon for Mobile Money
                  const SizedBox(width: 10), // Space between icon and text
                  Text(
                    'Mobile Money',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ), // Text color set to black
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Mobile Money option
            ElevatedButton(
              onPressed: () {
                // Mobile Money selected, navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paymentnetwork(
                      paymentMethod: 'Mobile Money',
                      paymentIcon: Icons.money, // Example icon
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.yellow,
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.red,
                  ), // Icon for Mobile Money
                  const SizedBox(width: 10), // Space between icon and text
                  Text(
                    'Selecom payment',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ), // Text color set to black
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
