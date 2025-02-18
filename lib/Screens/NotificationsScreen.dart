import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of customer notifications
    final List<Map<String, String>> notifications = [
      {
        'title': 'Order Confirmed',
        'message': 'Your order #12345 has been confirmed. Get ready!',
        'timeAgo': '5 minutes ago',
      },
      {
        'title': 'Order Shipped',
        'message': 'Your order #12345 is on the way!',
        'timeAgo': '30 minutes ago',
      },
      {
        'title': 'Payment Successful',
        'message': 'Your payment for order #12346 was successful. Enjoy!',
        'timeAgo': '1 hour ago',
      },
      {
        'title': 'Delivery Update',
        'message': 'Your order #12347 will arrive tomorrow!',
        'timeAgo': '3 hours ago',
      },
      {
        'title': 'Exclusive Offer',
        'message': 'Get 20% off on your next purchase! Limited time only.',
        'timeAgo': '1 day ago',
      },
      {
        'title': 'Security Alert',
        'message': 'Your account was accessed from a new device. Verify now!',
        'timeAgo': '1 day ago',
      },
      {
        'title': 'New Product Alert',
        'message': 'Check out our latest arrivals! Special discounts inside.',
        'timeAgo': '2 days ago',
      },
      {
        'title': 'Payment Successful',
        'message': 'Your payment for order #12346 was successful. Thank you!',
        'timeAgo': '1 hour ago',
      },
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
            const SizedBox(height: 50), // Space for status bar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 30),
                Text("Your Notifications",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      //fontWeight: FontWeight.bold,
                    )),
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        color: const Color.fromARGB(255, 253, 249, 0)
                            .withOpacity(0.9),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.notifications_active,
                              color: Color.fromARGB(255, 30, 61, 233)),
                          title: Text(
                            notification['title']!,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            notification['message']!,
                            style: GoogleFonts.lato(fontSize: 14),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                notification['timeAgo']!,
                                style: GoogleFonts.lato(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
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
}
