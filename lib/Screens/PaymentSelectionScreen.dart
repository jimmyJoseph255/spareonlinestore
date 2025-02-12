import 'package:flutter/material.dart';
import 'NextScreen.dart'; // Import the NextScreen

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment Method'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text for "Choose Payment Method"
            const Text(
              'Choose Payment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
                backgroundColor: Colors.white,
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
                  const Text(
                    'Cash on Delivery',
                    style: TextStyle(color: Colors.black),
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
                    builder: (context) => NextScreen(
                      paymentMethod: 'Mobile Money',
                      paymentIcon: Icons.money, // Example icon
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.white,
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
                  const Text(
                    'Mobile Money',
                    style: TextStyle(
                        color: Colors.black), // Text color set to black
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
