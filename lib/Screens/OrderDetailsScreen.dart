import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID Section
            Text('Order ID: $orderId',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 16),

            // Customer Name Section
            const Text('Customer Name: John Doe',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),

            // Phone Number Section
            const Text('Phone Number: 0710661252',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),

            // Payment Status Section with RichText for styling "Paid" separately
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(text: 'Payment Status: '),
                  TextSpan(
                    text: 'Paid',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 255, 8),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),

            // CardView for Upload Receipt
            GestureDetector(
              onTap: () {
                // Add action for uploading receipt (e.g., open camera or gallery)
                print('Upload Receipt tapped!');
              },
              child: Card(
                color: const Color.fromARGB(255, 243, 239, 0),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Upload Receipt',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Icon(Icons.camera_alt, color: Colors.grey, size: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
