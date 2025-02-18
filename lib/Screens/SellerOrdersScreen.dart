import 'package:flutter/material.dart';
import 'package:myproject/Screens/AcceptedOrdersScreen.dart';
import 'package:myproject/Screens/RejectedOrdersScreen.dart';
import 'package:myproject/Screens/PendingOrdersScreen.dart'; // Import the PendingOrdersScreen

class SellerOrdersScreen extends StatelessWidget {
  const SellerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 67, 164, 243), // Set the background color to white
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card for Accepted Orders
            _buildOrderCard(
              context,
              'Accepted Orders',
              80,
              isAccepted: true,
              onTap: () {
                // Navigate to Accepted Orders Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AcceptedOrdersScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Space between cards

            // Card for Rejected Orders
            _buildOrderCard(
              context,
              'Rejected Orders',
              30,
              isAccepted: false,
              isRejected: true,
              onTap: () {
                // Navigate to Rejected Orders Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RejectedOrdersScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Space between cards

            // Card for Pending Orders
            _buildOrderCard(
              context,
              'Pending Orders',
              70,
              isAccepted: false,
              isPending: true,
              onTap: () {
                // Navigate to Pending Orders Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PendingOrdersScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a card widget for orders
  Widget _buildOrderCard(BuildContext context, String title, int orderCount,
      {required bool isAccepted,
      bool isRejected = false,
      bool isPending = false,
      required VoidCallback onTap}) {
    return Card(
      color: const Color.fromARGB(255, 255, 251, 0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap, // Call the passed in onTap function
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side with title and order count
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(
                      height: 8), // Space between title and order count
                  Text('$orderCount orders', // Show the number of orders
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
              // Right side with the appropriate status icon
              if (isAccepted)
                const Icon(Icons.check_circle,
                    color: Colors.green, size: 30), // Accepted
              if (isRejected)
                const Icon(Icons.cancel,
                    color: Colors.red, size: 30), // Rejected
              if (isPending)
                const Icon(Icons.hourglass_empty,
                    color: Colors.orange, size: 30), // Pending
            ],
          ),
        ),
      ),
    );
  }
}
