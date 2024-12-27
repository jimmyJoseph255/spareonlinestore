import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Adjust based on the number of notifications you have
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.notifications),
              title: Text('Notification #$index'),
              subtitle: const Text('You have a new notification!'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap (if necessary)
              },
            );
          },
        ),
      ),
    );
  }
}
