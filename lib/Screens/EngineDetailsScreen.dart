import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/FavoritesScreen.dart'; // Import the FavoritesScreen
import 'package:myproject/Screens/accountscreen.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';
import 'enginedetailsinside.dart'; // Your engine details inside screen

class EngineDetailsScreen extends StatefulWidget {
  const EngineDetailsScreen({super.key});

  @override
  State<EngineDetailsScreen> createState() => _EngineDetailsScreenState();
}

class _EngineDetailsScreenState extends State<EngineDetailsScreen> {
  final List<Map<String, String>> Engine = const [
    {
      'name': 'Engine Part A',
      'price': '200 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Engine Part B',
      'price': '300 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Engine Part C',
      'price': '450 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Engine Part C',
      'price': '200 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Engine Part C',
      'price': '450 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain',
    },
    {
      'name': 'Engine Part C',
      'price': '40 USD',
      'image':
          'https://th.bing.com/th/id/OIP.AVdXQ4qKtnGcqpP02_iXjAHaGu?rs=1&pid=ImgDetMain',
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

  List<Map<String, String>> _filteredEngine = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredEngine = List.from(Engine);
  }

  void _sortEngine(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredEngine.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _filteredEngine.sort((a, b) => int.parse(a['price']!.split(' ')[0])
            .compareTo(int.parse(b['price']!.split(' ')[0])));
      }
    });
  }

  void _searchEngine(String query) {
    setState(() {
      _searchQuery = query;
      _filteredEngine = Engine.where((Engine) =>
          Engine['name']!.toLowerCase().contains(query.toLowerCase())).toList();
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
          'Engine Parts Details',
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
                    onChanged: _searchEngine,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Engine Parts',
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
                  onSelected: _sortEngine,
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
                    itemCount: _filteredEngine.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final engine = _filteredEngine[index];
                      final isFavorite = favoriteProvider.isFavorite(engine);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EngineDetailsInside(
                                productName: engine['name']!,
                                productPrice: engine['price']!,
                                productImage: engine['image']!,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          color: _cardColors[index % _cardColors.length],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.network(engine['image']!,
                                        fit: BoxFit.contain),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      engine['name']!,
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
                                      '${engine['price']} USD',
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
                                    favoriteProvider.toggleFavorite(engine);
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
