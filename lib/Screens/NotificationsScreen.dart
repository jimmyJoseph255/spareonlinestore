import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'package:myproject/Screens/NotificationDetailScreen.dart';
import 'package:myproject/Screens/PaymentDetailsScreen.dart'; // For random number generation

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications =
        _generateRandomNotifications(200);

    final List<Color> avatarColors = [
      Colors.blueAccent,
      Colors.green,
      Colors.redAccent,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.deepOrange,
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ABE2), Color(0xFF5563DE)], // Sky Blue Gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40), // Space for status bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Notifications",
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Card(
                        color: const Color.fromARGB(255, 253, 249, 0)
                            .withOpacity(0.9),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                avatarColors[index % avatarColors.length],
                            child: Text(
                              notification['title']![
                                  0], // First letter of the title
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            notification['title']!,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          subtitle: Text(
                            notification['message']!,
                            style: GoogleFonts.lato(fontSize: 13),
                          ),
                          trailing: Text(
                            notification['timeAgo']!,
                            style: GoogleFonts.lato(
                                fontSize: 12, color: Colors.grey),
                          ),
                          onTap: () {
                            // Navigation logic remains unchanged
                            switch (notification['type']) {
                              case 'order':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetailsScreen(
                                      orderId: notification['orderId']!,
                                    ),
                                  ),
                                );
                                break;
                              case 'payment':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentDetailsScreen(
                                      amount: notification['amount']!,
                                    ),
                                  ),
                                );
                                break;
                              case 'security':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SecurityAlertScreen(
                                      device: notification['device']!,
                                    ),
                                  ),
                                );
                                break;
                              case 'offer':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OfferDetailsScreen(
                                      discountCode:
                                          notification['discountCode']!,
                                    ),
                                  ),
                                );
                                break;
                              default:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationDetailScreen(
                                      title: notification['title']!,
                                      message: notification['message']!,
                                      timeAgo: notification['timeAgo']!,
                                    ),
                                  ),
                                );
                                break;
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to generate random notifications
  List<Map<String, String>> _generateRandomNotifications(int count) {
    final List<String> types = [
      'order',
      'payment',
      'security',
      'offer',
      'general'
    ];
    final Random random = Random();
    final List<Map<String, String>> notifications = [];

    for (int i = 0; i < count; i++) {
      final type = types[random.nextInt(types.length)];
      final title = _generateRandomTitle(type);
      final message = _generateRandomMessage(type);
      final timeAgo = _generateRandomTimeAgo();

      notifications.add({
        'title': title,
        'message': message,
        'timeAgo': timeAgo,
        'type': type,
        if (type == 'order') 'orderId': (i + 10000).toString(),
        if (type == 'payment')
          'amount': '\$${(random.nextInt(100) + 50).toString()}.00',
        if (type == 'security') 'device': 'Device ${random.nextInt(100)}',
        if (type == 'offer') 'discountCode': 'SAVE${random.nextInt(100)}',
      });
    }

    return notifications;
  }

  String _generateRandomTitle(String type) {
    switch (type) {
      case 'order':
        return 'Order Confirmed';
      case 'payment':
        return 'Payment Successful';
      case 'security':
        return 'Security Alert';
      case 'offer':
        return 'Exclusive Offer';
      default:
        return 'New Product Alert';
    }
  }

  String _generateRandomMessage(String type) {
    switch (type) {
      case 'order':
        return 'Your order has been confirmed. Get ready!';
      case 'payment':
        return 'Your payment was successful.';
      case 'security':
        return 'Your account was accessed from a new device.';
      case 'offer':
        return 'Get 20% off on your next purchase! Limited time only.';
      default:
        return 'Check out our latest arrivals! Special discounts inside.';
    }
  }

  String _generateRandomTimeAgo() {
    final random = Random();
    final timeAgoOptions = [
      '5 minutes ago',
      '1 hour ago',
      '1 day ago',
      '2 days ago',
      '3 days ago'
    ];
    return timeAgoOptions[random.nextInt(timeAgoOptions.length)];
  }
}

// Different Screens Based on Notification Type

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: Center(child: Text("Details for Order ID: $orderId")),
    );
  }
}
