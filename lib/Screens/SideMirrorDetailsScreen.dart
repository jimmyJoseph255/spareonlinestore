import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/FavoritesScreen.dart';
import 'package:myproject/Screens/accountscreen.dart';
import 'cart_screen.dart';
import 'sidemirrordetailsinside.dart'; // Your side mirror details screen inside

class SideMirrorDetailsScreen extends StatefulWidget {
  const SideMirrorDetailsScreen({super.key});

  @override
  State<SideMirrorDetailsScreen> createState() =>
      _SideMirrorDetailsScreenState();
}

class _SideMirrorDetailsScreenState extends State<SideMirrorDetailsScreen> {
  final List<Map<String, String>> products = const [
    {
      'name': 'Side Mirror A',
      'price': '30 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Side Mirror B',
      'price': '45 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Side Mirror C',
      'price': '60 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Side Mirror C',
      'price': '160 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Side Mirror C',
      'price': '260 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Side Mirror C',
      'price': '60 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
  ];

  List<Map<String, String>> _sortedProducts = [];
  final Set<Map<String, String>> _favoriteItems = {};

  @override
  void initState() {
    super.initState();
    _sortedProducts = List.from(products);
  }

  void _sortProducts(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _sortedProducts.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _sortedProducts.sort((a, b) => int.parse(a['price']!.split(' ')[0])
            .compareTo(int.parse(b['price']!.split(' ')[0])));
      }
    });
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CartScreen()));
    } else if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()));
    } else if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AccountScreen()));
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FavoritesScreen(favoriteItems: _favoriteItems.toList()),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Side Mirror Details',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
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
                      hintText: 'Search Side Mirrors',
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
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: _sortProducts,
                  color: Colors.white,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 'Alphabetical', child: Text('Sort A-Z')),
                    const PopupMenuItem(
                        value: 'Price', child: Text('Sort by Price')),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: _sortedProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = _sortedProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SideMirrorDetailsInside(
                            productName: product['name']!,
                            productPrice: product['price']!,
                            productImage: product['image']!,
                          ),
                        ),
                      );
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}
