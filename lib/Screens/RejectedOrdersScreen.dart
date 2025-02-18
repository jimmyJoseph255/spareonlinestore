import 'package:flutter/material.dart';

class RejectedOrdersScreen extends StatelessWidget {
  const RejectedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 67, 164, 243), // Set the background color to white
      appBar: AppBar(
        title: const Text('Rejected Orders'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Example number of rejected orders
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 250, 233, 0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () {
                  // You can add navigation to order details screen here if needed
                  // For now, it just shows the card details
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Icon on the left side representing rejected status
                      const Icon(Icons.cancel, color: Colors.red, size: 30),
                      const SizedBox(width: 16), // Space between icon and text
                      // Order details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order #${index + 1}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text('Order Date: 2024-10-27 08:04:40'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
