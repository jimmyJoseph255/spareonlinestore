import 'package:flutter/material.dart';

class SellerCarTyresDetailsScreen extends StatefulWidget {
  const SellerCarTyresDetailsScreen({super.key});

  @override
  State<SellerCarTyresDetailsScreen> createState() =>
      _SellerCarTyresDetailsScreenState();
}

class _SellerCarTyresDetailsScreenState
    extends State<SellerCarTyresDetailsScreen> {
  final List<Map<String, String>> carTyres = const [
    {
      'name': 'Pirelli Cinturato P7',
      'price': '42500 ₸',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Michelin Pilot Sport 4',
      'price': '300 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Michelin Pilot Sport 4',
      'price': '300 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Michelin Pilot Sport 4',
      'price': '300 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Michelin Pilot Sport 4',
      'price': '300 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Michelin Pilot Sport 4',
      'price': '300 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
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
          'Car Tyres Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: carTyres.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final tyre = carTyres[index];
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
                      tyre['image']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tyre['name']!,
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
                      tyre['price']!,
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
