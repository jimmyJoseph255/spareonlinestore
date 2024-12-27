import 'package:flutter/material.dart';

class SellerSpeakersDetailsScreen extends StatefulWidget {
  const SellerSpeakersDetailsScreen({super.key});

  @override
  State<SellerSpeakersDetailsScreen> createState() =>
      _SellerSpeakersDetailsScreenState();
}

class _SellerSpeakersDetailsScreenState
    extends State<SellerSpeakersDetailsScreen> {
  final List<Map<String, String>> products = const [
    {
      'name': 'JBL Flip 5',
      'price': '150 USD',
      'image': 'https://m.media-amazon.com/images/I/818rupP5TWL.jpg',
    },
    {
      'name': 'Sony SRS-XB43',
      'price': '200 USD',
      'image': 'https://m.media-amazon.com/images/I/818rupP5TWL.jpg',
    },
    {
      'name': 'Bose SoundLink',
      'price': '250 USD',
      'image': 'https://m.media-amazon.com/images/I/818rupP5TWL.jpg',
    },
    {
      'name': 'Bose SoundLink',
      'price': '250 USD',
      'image': 'https://m.media-amazon.com/images/I/818rupP5TWL.jpg',
    },
    {
      'name': 'Bose SoundLink',
      'price': '250 USD',
      'image': 'https://m.media-amazon.com/images/I/818rupP5TWL.jpg',
    },
    {
      'name': 'Bose SoundLink',
      'price': '250 USD',
      'image': 'https://m.media-amazon.com/images/I/818rupP5TWL.jpg',
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
          'Speaker Details',
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
