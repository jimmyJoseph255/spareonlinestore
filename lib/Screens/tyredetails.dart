import 'dart:math'; // Import the math library for Random
import 'package:flutter/material.dart';
import 'package:myproject/Screens/speakerdetailsinside.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/FavoritesScreen.dart';
import 'package:myproject/Screens/accountscreen.dart';
import 'cart_screen.dart';

class TyreDetailsScreen extends StatefulWidget {
  const TyreDetailsScreen({super.key});

  @override
  State<TyreDetailsScreen> createState() => _TyreDetailsScreenState();
}

class _TyreDetailsScreenState extends State<TyreDetailsScreen> {
  final List<Map<String, String>> tyres = const [
    {
      'name': 'Pirelli Cinturato P7',
      'price': '42500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Cinturato P7',
      'price': '500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Pirelli',
      'price': '500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'P7',
      'price': '500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Pirelli',
      'price': '500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Pirelli',
      'price': '500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'lli',
      'price': '500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Pelli',
      'price': '500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
  ];

  // List of predefined colors for each card
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

  List<Map<String, String>> _filteredTyres = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredTyres = List.from(tyres);
  }

  void _sortTyres(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredTyres.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _filteredTyres.sort((a, b) {
          int priceA = int.tryParse(a['price']!) ?? 0;
          int priceB = int.tryParse(b['price']!) ?? 0;
          return priceA.compareTo(priceB);
        });
      }
    });
  }

  void _searchTyres(String query) {
    setState(() {
      _searchQuery = query;
      _filteredTyres = tyres
          .where((tyre) =>
              tyre['name']!.toLowerCase().contains(query.toLowerCase()))
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
          context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
    }
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
          'Tyre Details',
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
                    onChanged: _searchTyres,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Tyres',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: _sortTyres,
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
                    itemCount: _filteredTyres.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final tyre = _filteredTyres[index];
                      final isFavorite = favoriteProvider.isFavorite(tyre);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpeakerDetailsInside(
                                productName: tyre['name']!,
                                productPrice: tyre['price']!,
                                productImage: tyre['image']!,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          color: _cardColors[index %
                              _cardColors.length], // Assign predefined color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.network(tyre['image']!,
                                        fit: BoxFit.contain),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      '${tyre['price']} USD',
                                      style: const TextStyle(
                                        color: Colors.black,
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
                                    favoriteProvider.toggleFavorite(tyre);
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
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 67, 164, 243)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
              backgroundColor: Color.fromARGB(255, 67, 164, 243)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
              backgroundColor: Color.fromARGB(255, 67, 164, 243)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
              backgroundColor: Color.fromARGB(255, 67, 164, 243)),
        ],
      ),
    );
  }
}
