import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/FavoritesScreen.dart';
import 'package:myproject/Screens/accountscreen.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';
import 'sidemirrordetailsinside.dart'; // Your side mirror details screen inside

class SideMirrorDetailsScreen extends StatefulWidget {
  const SideMirrorDetailsScreen({super.key});

  @override
  State<SideMirrorDetailsScreen> createState() =>
      _SideMirrorDetailsScreenState();
}

class _SideMirrorDetailsScreenState extends State<SideMirrorDetailsScreen> {
  final List<Map<String, String>> sidemirror = const [
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
      'name': 'Side Mirror D',
      'price': '160 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Side Mirror E',
      'price': '260 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Side Mirror F',
      'price': '60 USD',
      'image':
          'https://th.bing.com/th/id/OIP.RNTNkdRzVYApwVHmKP-UGAHaHa?rs=1&pid=ImgDetMain',
    },
  ];

  List<Map<String, String>> _filteredsidemirror = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredsidemirror = List.from(sidemirror);
  }

  void _sortsidemirror(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredsidemirror.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _filteredsidemirror.sort((a, b) =>
            int.parse(a['price']!.replaceAll(' USD', ''))
                .compareTo(int.parse(b['price']!.replaceAll(' USD', ''))));
      }
    });
  }

  void _searchbsidemirror(String query) {
    setState(() {
      _searchQuery = query;
      _filteredsidemirror = sidemirror
          .where((sidemirror) =>
              sidemirror['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
            builder: (context) => FavoritesScreen(),
          ));
    }
  }

  // Method to generate a random color
  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
      1.0, // Opacity
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
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
                    onChanged: _searchbsidemirror,
                  ),
                ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: _sortsidemirror,
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
              child: Consumer<FavoriteProvider>(
                builder: (context, favoriteProvider, child) {
                  return GridView.builder(
                    itemCount: _filteredsidemirror.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final sidemirror = _filteredsidemirror[index];
                      final isFavorite =
                          favoriteProvider.isFavorite(sidemirror);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SideMirrorDetailsInside(
                                productName: sidemirror['name']!,
                                productPrice: sidemirror['price']!,
                                productImage: sidemirror['image']!,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          color: _generateRandomColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.network(sidemirror['image']!,
                                        fit: BoxFit.contain),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      sidemirror['name']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      '${sidemirror['price']}',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 8,
                                right: 2,
                                child: IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    favoriteProvider.toggleFavorite(sidemirror);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: const Color.fromARGB(255, 67, 164, 243),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            backgroundColor: const Color.fromARGB(255, 67, 164, 243),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: const Color.fromARGB(255, 67, 164, 243),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: const Color.fromARGB(255, 67, 164, 243),
          ),
        ],
      ),
    );
  }
}
