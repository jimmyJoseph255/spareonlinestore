import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myproject/Screens/Dashboard/DashboardScreen.dart';

import 'package:myproject/Screens/account/accountscreen.dart';
import 'package:myproject/Screens/cart/cart_screen.dart';
import 'package:myproject/Screens/widgets/FavoritesScreen.dart';

import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

import 'brakesystemdetailsinside.dart';

class BrakeDetailsScreen extends StatefulWidget {
  const BrakeDetailsScreen({super.key});

  @override
  State<BrakeDetailsScreen> createState() => _BrakeDetailsScreenState();
}

class _BrakeDetailsScreenState extends State<BrakeDetailsScreen> {
  final List<Map<String, String>> brakes = const [
    {
      'name': 'Brake Pad Set A',
      'price': '50',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0',
    },
    {
      'name': 'Brake Disc Set B',
      'price': '120',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0',
    },
    {
      'name': 'Brake Calipers C',
      'price': '150',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0',
    },
    {
      'name': 'Brake Calipers C',
      'price': '150',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0',
    },
    {
      'name': 'Brake Calipers C',
      'price': '150',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0',
    },
    {
      'name': 'Brake Calipers C',
      'price': '150',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0',
    },
    {
      'name': 'Brake Calipers C',
      'price': '10',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0',
    },
    {
      'name': 'Brake Calipers C',
      'price': '150',
      'image':
          'https://th.bing.com/th/id/R.85e826cac7ef3f9bc00145e2a8d41430?rik=%2fvjnTxkmmEEySA&pid=ImgRaw&r=0',
    },
  ];

  final List<Color> _cardColors = [
    Colors.yellow,
    const Color.fromARGB(255, 255, 0, 212),
    const Color.fromARGB(255, 161, 154, 167),
    const Color.fromARGB(255, 72, 255, 0),
    const Color.fromARGB(255, 255, 153, 0),
    const Color.fromARGB(255, 217, 0, 255),
    const Color.fromARGB(255, 0, 236, 217),
    const Color.fromARGB(255, 182, 40, 90),
  ];

  List<Map<String, String>> _filteredbrakes = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredbrakes = List.from(brakes);
  }

  void _sortbrakes(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredbrakes.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _filteredbrakes.sort(
            (a, b) => int.parse(a['price']!).compareTo(int.parse(b['price']!)));
      }
    });
  }

  void _searchbrakes(String query) {
    setState(() {
      _searchQuery = query;
      _filteredbrakes = brakes
          .where((brakes) =>
              brakes['name']!.toLowerCase().contains(query.toLowerCase()))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Silent back navigation when the back button is tapped
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        title: const Text(
          'Brake System Details',
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
                    onChanged: _searchbrakes, // Update the search query
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
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: _sortbrakes,
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
                    itemCount: _filteredbrakes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final brakes = _filteredbrakes[index];
                      final isFavorite = favoriteProvider.isFavorite(brakes);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BrakeSystemDetailsInside(
                                productName: brakes['name']!,
                                productPrice: brakes['price']!,
                                productImage: brakes['image']!,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          color: _cardColors[index %
                              _cardColors.length], // Assign a random color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.network(brakes['image']!,
                                        fit: BoxFit.contain),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      brakes['name']!,
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
                                      '${brakes['price']} USD',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
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
                                    favoriteProvider.toggleFavorite(brakes);
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
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
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
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}
