import 'package:flutter/material.dart';

class SellerBrakeSystemDetailsScreen extends StatefulWidget {
  const SellerBrakeSystemDetailsScreen({super.key});

  @override
  State<SellerBrakeSystemDetailsScreen> createState() =>
      _SellerBrakeSystemDetailsScreenState();
}

class _SellerBrakeSystemDetailsScreenState
    extends State<SellerBrakeSystemDetailsScreen> {
  // List of brake system products
  final List<Map<String, String>> brakeSystems = const [
    {
      'name': 'Brembo Brake Pad',
      'price': '100 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Akebono Brake Kit',
      'price': '150 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Bosch Brake Disc',
      'price': '120 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Mintex Brake Pads',
      'price': '80 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Ferodo Brake Kit',
      'price': '130 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'EBC Brake Pads',
      'price': '90 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Brake System Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: brakeSystems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final brakeSystem = brakeSystems[index];
            return Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.network(
                      brakeSystem['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      brakeSystem['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      brakeSystem['price']!,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set default active tab
        onTap: (index) {
          // Handle tab navigation
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
