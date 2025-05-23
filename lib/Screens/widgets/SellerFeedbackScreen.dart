import 'package:flutter/material.dart';
import 'package:myproject/Screens/Dashboard/SellerDashboardScreen.dart';

class SellerFeedbackScreen extends StatelessWidget {
  const SellerFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const SellerDashboardScreen()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 67, 164, 243), // Set background color to white
        appBar: AppBar(
          title: Text(
            'Feedback',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 67, 164, 243),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SellerDashboardScreen()),
              );
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: 10, // Example number of feedback entries
            itemBuilder: (context, index) {
              return Card(
                color: const Color.fromARGB(255, 255, 251, 0),
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
      ),
    );
  }
}
