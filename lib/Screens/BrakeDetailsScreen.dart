import 'package:flutter/material.dart';
import 'cart_screen.dart'; // Import the CartScreen
import 'tyredetailsinside.dart'; // Use the same inside screen for simplicity

class BrakeDetailsScreen extends StatefulWidget {
  const BrakeDetailsScreen({super.key});

  @override
  State<BrakeDetailsScreen> createState() => _BrakeDetailsScreenState();
}

class _BrakeDetailsScreenState extends State<BrakeDetailsScreen> {
  // List of brake system products
  final List<Map<String, String>> products = const [
    {
      'name': 'Brake Pad Set A',
      'price': '50 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Brake Disc Set B',
      'price': '120 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
    {
      'name': 'Brake Calipers C',
      'price': '150 USD',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0', // Replace with actual image URL
    },
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Brake System Details',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Brake Systems',
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
                      color: Colors.white, // Set card background color to white
                      elevation: 2,
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
