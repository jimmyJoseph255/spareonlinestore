import 'package:flutter/material.dart';

class SellerEngineDetailsScreen extends StatefulWidget {
  const SellerEngineDetailsScreen({super.key});

  @override
  State<SellerEngineDetailsScreen> createState() =>
      _SellerEngineDetailsScreenState();
}

class _SellerEngineDetailsScreenState extends State<SellerEngineDetailsScreen> {
  // List of engine products
  final List<Map<String, String>> products = const [
    {
      'name': 'Engine Block A',
      'price': '500 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain', // Replace with actual image URL
    },
    {
      'name': 'Cylinder Head B',
      'price': '350 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain', // Replace with actual image URL
    },
    {
      'name': 'Crankshaft C',
      'price': '400 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain', // Replace with actual image URL
    },
    {
      'name': 'Piston D',
      'price': '200 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain', // Replace with actual image URL
    },
    {
      'name': 'Timing Belt E',
      'price': '80 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain', // Replace with actual image URL
    },
    {
      'name': 'Oil Pump F',
      'price': '150 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain', // Replace with actual image URL
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
          'Engine Details',
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
