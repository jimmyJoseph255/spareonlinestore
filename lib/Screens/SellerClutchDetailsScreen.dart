import 'package:flutter/material.dart';
import 'cart_screen.dart'; // Import the CartScreen

class SellerClutchDetailsScreen extends StatefulWidget {
  const SellerClutchDetailsScreen({super.key});

  @override
  State<SellerClutchDetailsScreen> createState() =>
      _SellerClutchDetailsScreenState();
}

class _SellerClutchDetailsScreenState extends State<SellerClutchDetailsScreen> {
  // List of clutch system products
  final List<Map<String, String>> products = const [
    {
      'name': 'Clutch Plate A',
      'price': '40 USD',
      'image':
          'https://th.bing.com/th/id/R.ef3a57e08b3d780fe397ecc75fbb66fe?rik=e1vsHo3JiNaeIw&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Clutch Kit B',
      'price': '90 USD',
      'image':
          'https://th.bing.com/th/id/R.ef3a57e08b3d780fe397ecc75fbb66fe?rik=e1vsHo3JiNaeIw&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Clutch Master Cylinder C',
      'price': '120 USD',
      'image':
          'https://th.bing.com/th/id/R.ef3a57e08b3d780fe397ecc75fbb66fe?rik=e1vsHo3JiNaeIw&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Clutch Master Cylinder C',
      'price': '120 USD',
      'image':
          'https://th.bing.com/th/id/R.ef3a57e08b3d780fe397ecc75fbb66fe?rik=e1vsHo3JiNaeIw&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Clutch Master Cylinder C',
      'price': '120 USD',
      'image':
          'https://th.bing.com/th/id/R.ef3a57e08b3d780fe397ecc75fbb66fe?rik=e1vsHo3JiNaeIw&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Clutch Master Cylinder C',
      'price': '120 USD',
      'image':
          'https://th.bing.com/th/id/R.ef3a57e08b3d780fe397ecc75fbb66fe?rik=e1vsHo3JiNaeIw&pid=ImgRaw&r=0', // Replace with actual image URL
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
          'Clutch System Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                // Handle navigation when a product is tapped
                // For now, just print the product name
                print('Tapped on ${product['name']}');
              },
              child: Card(
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
                        product['image']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product['name']!,
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
                        product['price']!,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set default active tab
        onTap: (index) {
          // Handle tab navigation here
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}
