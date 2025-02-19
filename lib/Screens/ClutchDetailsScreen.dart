import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/FavoritesScreen.dart';
import 'package:myproject/Screens/accountscreen.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';
import 'clutchdetailsinside.dart';

class ClutchDetailsScreen extends StatefulWidget {
  const ClutchDetailsScreen({super.key});

  @override
  State<ClutchDetailsScreen> createState() => _ClutchDetailsScreenState();
}

class _ClutchDetailsScreenState extends State<ClutchDetailsScreen> {
  final List<Map<String, String>> clutch = const [
    {
      'name': 'Clutch Plate A',
      'price': '40 USD',
      'image':
          'https://th.bing.com/th/id/R.f92af3994d54687d79c33d6e1f4ecdf7?rik=01aAoLDO%2biizdQ&riu=http%3a%2f%2fcenterlinealfa.com%2fsites%2fcenterlinealfa.com%2fassets%2fimages%2fCategory_Images%2fclutch.png&ehk=3VQTK90QkHeP%2bpUFe5OHErDnybLIL%2fz9FnjzAvPDHD4%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'Clutch Kit B',
      'price': '90 USD',
      'image':
          'https://th.bing.com/th/id/R.f92af3994d54687d79c33d6e1f4ecdf7?rik=01aAoLDO%2biizdQ&riu=http%3a%2f%2fcenterlinealfa.com%2fsites%2fcenterlinealfa.com%2fassets%2fimages%2fCategory_Images%2fclutch.png&ehk=3VQTK90QkHeP%2bpUFe5OHErDnybLIL%2fz9FnjzAvPDHD4%3d&risl=&pid=ImgRaw&r=0',
    },
    {
      'name': 'Clutch Master Cylinder C',
      'price': '120 USD',
      'image':
          'https://th.bing.com/th/id/R.f92af3994d54687d79c33d6e1f4ecdf7?rik=01aAoLDO%2biizdQ&riu=http%3a%2f%2fcenterlinealfa.com%2fsites%2fcenterlinealfa.com%2fassets%2fimages%2fCategory_Images%2fclutch.png&ehk=3VQTK90QkHeP%2bpUFe5OHErDnybLIL%2fz9FnjzAvPDHD4%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'Clutch Master Cylinder D',
      'price': '80 USD',
      'image':
          'https://th.bing.com/th/id/R.f92af3994d54687d79c33d6e1f4ecdf7?rik=01aAoLDO%2biizdQ&riu=http%3a%2f%2fcenterlinealfa.com%2fsites%2fcenterlinealfa.com%2fassets%2fimages%2fCategory_Images%2fclutch.png&ehk=3VQTK90QkHeP%2bpUFe5OHErDnybLIL%2fz9FnjzAvPDHD4%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'Clutch Kit E',
      'price': '100 USD',
      'image':
          'https://th.bing.com/th/id/R.f92af3994d54687d79c33d6e1f4ecdf7?rik=01aAoLDO%2biizdQ&riu=http%3a%2f%2fcenterlinealfa.com%2fsites%2fcenterlinealfa.com%2fassets%2fimages%2fCategory_Images%2fclutch.png&ehk=3VQTK90QkHeP%2bpUFe5OHErDnybLIL%2fz9FnjzAvPDHD4%3d&risl=&pid=ImgRaw&r=0'
    },
  ];

  final List<Color> _cardColors = [
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.cyan,
  ];

  List<Map<String, String>> _filteredclutch = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredclutch = List.from(clutch);
  }

  void _sortclutch(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredclutch.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _filteredclutch.sort((a, b) =>
            int.parse(a['price']!.replaceAll(' USD', ''))
                .compareTo(int.parse(b['price']!.replaceAll(' USD', ''))));
      }
    });
  }

  void _searchclutch(String query) {
    setState(() {
      _searchQuery = query;
      _filteredclutch = clutch
          .where((clutch) =>
              clutch['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FavoritesScreen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CartScreen()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AccountScreen()));
        break;
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
          'Clutch System Details',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchSortBar(),
          _buildClutchGrid(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchSortBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: _searchclutch,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Clutch Systems',
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
            onSelected: _sortclutch,
            color: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'Alphabetical', child: Text('Sort A-Z')),
              const PopupMenuItem(value: 'Price', child: Text('Sort by Price')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClutchGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, child) {
            return GridView.builder(
              itemCount: _filteredclutch.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final clutch = _filteredclutch[index];
                final isFavorite = favoriteProvider.isFavorite(clutch);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClutchDetailsInside(
                          productName: clutch['name']!,
                          productPrice: clutch['price']!,
                          productImage: clutch['image']!,
                        ),
                      ),
                    );
                  },
                  child: _buildClutchCard(
                      clutch, isFavorite, favoriteProvider, index),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildClutchCard(Map<String, String> clutch, bool isFavorite,
      FavoriteProvider favoriteProvider, int index) {
    return Card(
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
                child: Image.network(clutch['image']!, fit: BoxFit.contain),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  clutch['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'Account'),
      ],
    );
  }
}
