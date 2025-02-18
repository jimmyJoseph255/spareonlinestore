import 'package:flutter/material.dart';
import 'package:myproject/Screens/OrderDetailsScreen.dart'; // Import the OrderDetailsScreen

class AcceptedOrdersScreen extends StatelessWidget {
  const AcceptedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: const Text('Accepted Orders'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Example number of accepted orders
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 255, 238, 0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () {
                  // Navigate to OrderDetailsScreen with the order ID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderDetailsScreen(orderId: index + 1),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Icon on the left side representing accepted status
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 30),
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
