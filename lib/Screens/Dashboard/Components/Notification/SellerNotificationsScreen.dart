import 'package:flutter/material.dart';
import 'package:myproject/Screens/Dashboard/Components/Notification/SellerNotificationDetails.dart';

class SellerNotificationsScreen extends StatelessWidget {
  const SellerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of notifications with order ID, product name, and time
    final List<Map<String, String>> notifications = [
      {
        'orderId': '12345',
        'productName': 'Pirelli Cinturato P7',
        'timeAgo': '5 minutes ago',
      },
      {
        'orderId': '12346',
        'productName': 'Michelin Pilot Sport 4',
        'timeAgo': '10 minutes ago',
      },
      {
        'orderId': '12347',
        'productName': 'Goodyear Eagle F1',
        'timeAgo': '20 minutes ago',
      },
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                // Navigate to the details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SellerNotificationDetails(notification: notification),
                  ),
                );
              },
              child: Card(
                color: const Color.fromARGB(255, 255, 217, 0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ID: ${notification['orderId']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${notification['productName']}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${notification['timeAgo']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
