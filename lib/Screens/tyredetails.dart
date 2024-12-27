import 'package:flutter/material.dart';
import 'cart_screen.dart'; // Import the CartScreen
import 'tyredetailsinside.dart'; // Import the new screen file

class TyreDetailsScreen extends StatefulWidget {
  const TyreDetailsScreen({super.key});

  @override
  State<TyreDetailsScreen> createState() => _TyreDetailsScreenState();
}

class _TyreDetailsScreenState extends State<TyreDetailsScreen> {
  // List of tyre products
  final List<Map<String, String>> products = const [
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
      'name': 'Bridgestone Turanza T005',
      'price': '250 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Bridgestone Turanza T005',
      'price': '250 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Bridgestone Turanza T005',
      'price': '250 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Bridgestone Turanza T005',
      'price': '250 USD',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    }
  ];

  // Selected index for the BottomNavigationBar
  int _selectedIndex = 0;

  // Handle BottomNavigationBar taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      // Navigate to CartScreen when Cart icon is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the entire background color to white
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Tyre Details',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search and Sort Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Tyres',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
          // Product Grid
          Expanded(
            child: Padding(
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
                      // Navigate to TyreDetailsInside screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TyreDetailsInside(
                            productName: product['name']!,
                            productPrice: product['price']!,
                            productImage: product['image']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      color: Colors.white, // Set the Card background to white
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
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
