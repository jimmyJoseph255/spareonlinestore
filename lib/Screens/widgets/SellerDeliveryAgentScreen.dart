import 'package:flutter/material.dart';
import 'package:myproject/Screens/Dashboard/SellerDashboardScreen.dart';

class SellerDeliveryAgentScreen extends StatelessWidget {
  const SellerDeliveryAgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SellerDashboardScreen()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 67, 164, 243), // Set background color to white
        appBar: AppBar(
          title: Text(
            'Delivery Agent',
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
            itemCount:
                10, // Set to null or a large number for infinite scrolling
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
                        'Delivery Agent: James Isack',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Completed Deliveries
                      const Text(
                        'Completed Deliveries: 20',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),

                      // Phone Number
                      const Text(
                        'Phone Number: 0710661252',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),

                      // Rating
                      const Text(
                        'Rating: 3 out of 5',
                        style: TextStyle(fontSize: 14),
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
