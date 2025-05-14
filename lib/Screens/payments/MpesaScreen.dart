import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/orders/OrderStatusScreen.dart';

class MpesaScreen extends StatelessWidget {
  final String paymentMethod;
  final IconData paymentIcon;

  const MpesaScreen({
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
          'Payment Confirmation',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Payment method icon and title
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              child: Image.asset(
                'lib/images/payment-method.png',
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected Payment Method:',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              paymentMethod,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            // Payment details placeholder
            Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 141, 141),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Details:',
                    style: GoogleFonts.lato(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Amount: TZS 100,000\n• Receiver: My Shop Ltd\n• Payment Reference: #123456',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Proceed Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderStatusScreen(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Confirm & Proceed',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
