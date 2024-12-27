import 'package:flutter/material.dart';

class SellerFeedbackScreen extends StatelessWidget {
  const SellerFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Example number of feedback entries
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Agent Name
                    Text(
                      'Delivery Agent: James Isack ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Feedback Message
                    const Text(
                      'Feedback: Great delivery and on-time service.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),

                    // Rating Section
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        Icon(Icons.star_border, color: Colors.grey, size: 20),
                        Icon(Icons.star_border, color: Colors.grey, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
