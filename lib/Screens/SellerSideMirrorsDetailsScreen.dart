import 'package:flutter/material.dart';

class SellerSideMirrorsDetailsScreen extends StatefulWidget {
  const SellerSideMirrorsDetailsScreen({super.key});

  @override
  State<SellerSideMirrorsDetailsScreen> createState() =>
      _SellerSideMirrorsDetailsScreenState();
}

class _SellerSideMirrorsDetailsScreenState
    extends State<SellerSideMirrorsDetailsScreen> {
  final List<Map<String, String>> sideMirrors = const [
    {
      'name': 'Honda Civic Side Mirror',
      'price': '150 USD',
      'image':
          'https://cdn.pixabay.com/photo/2017/10/14/12/05/mirrors-2850352_960_720.png',
    },
    {
      'name': 'Toyota Corolla Side Mirror',
      'price': '130 USD',
      'image':
          'https://cdn.pixabay.com/photo/2017/10/14/12/05/mirrors-2850352_960_720.png',
    },
    {
      'name': 'BMW 3 Series Side Mirror',
      'price': '250 USD',
      'image':
          'https://cdn.pixabay.com/photo/2017/10/14/12/05/mirrors-2850352_960_720.png',
    },
    {
      'name': 'Audi A4 Side Mirror',
      'price': '220 USD',
      'image':
          'https://cdn.pixabay.com/photo/2017/10/14/12/05/mirrors-2850352_960_720.png',
    },
    {
      'name': 'Mercedes-Benz E-Class Side Mirror',
      'price': '280 USD',
      'image':
          'https://cdn.pixabay.com/photo/2017/10/14/12/05/mirrors-2850352_960_720.png',
    },
    {
      'name': 'Ford Mustang Side Mirror',
      'price': '180 USD',
      'image':
          'https://cdn.pixabay.com/photo/2017/10/14/12/05/mirrors-2850352_960_720.png',
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
          'Side Mirrors Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: sideMirrors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final mirror = sideMirrors[index];
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
                      mirror['image']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      mirror['name']!,
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
                      mirror['price']!,
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
