import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/FavoritesScreen.dart';
import 'package:myproject/Screens/accountscreen.dart';
import 'package:myproject/Screens/carbatterydetailsinside.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';

class CarBatteryDetailsScreen extends StatefulWidget {
  const CarBatteryDetailsScreen({super.key});

  @override
  State<CarBatteryDetailsScreen> createState() =>
      _CarBatteryDetailsScreenState();
}

class _CarBatteryDetailsScreenState extends State<CarBatteryDetailsScreen> {
  final List<Map<String, String>> carBatteries = const [
    {
      'name': 'Exide Car Battery 12V',
      'price': '120 USD',
      'image':
          'https://th.bing.com/th/id/R.45dbca628c0bc12387db677581a5b838?rik=v8IkvMtaeudZMQ&riu=http%3a%2f%2fpngimg.com%2fuploads%2fautomotive_battery%2fautomotive_battery_PNG12111.png&ehk=A5rRbFyhrgQaSXiclx4wk9MViEQ%2fd9jsipsE%2fPDpOXo%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'Bosch S5 Car Battery 12V',
      'price': '150 USD',
      'image':
          'https://th.bing.com/th/id/R.bbb14c3bea97aef6849b4300ba3086b2?rik=YQzEv7NkwOGDVA&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f5%2fCar-Battery-PNG-Transparent-Image.png&ehk=ypDxZyiMundt2%2f9HKUzf585sGA6lKiOVPJXmuxXxdAg%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'Varta Silver Car Battery',
      'price': '135 USD',
      'image':
          'https://th.bing.com/th/id/R.45dbca628c0bc12387db677581a5b838?rik=v8IkvMtaeudZMQ&riu=http%3a%2f%2fpngimg.com%2fuploads%2fautomotive_battery%2fautomotive_battery_PNG12111.png&ehk=A5rRbFyhrgQaSXiclx4wk9MViEQ%2fd9jsipsE%2fPDpOXo%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'ACDelco Car Battery',
      'price': '100 USD',
      'image':
          'https://th.bing.com/th/id/R.45dbca628c0bc12387db677581a5b838?rik=v8IkvMtaeudZMQ&riu=http%3a%2f%2fpngimg.com%2fuploads%2fautomotive_battery%2fautomotive_battery_PNG12111.png&ehk=A5rRbFyhrgQaSXiclx4wk9MViEQ%2fd9jsipsE%2fPDpOXo%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'Yuasa Car Battery',
      'price': '130 USD',
      'image':
          'https://th.bing.com/th/id/R.bbb14c3bea97aef6849b4300ba3086b2?rik=YQzEv7NkwOGDVA&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f5%2fCar-Battery-PNG-Transparent-Image.png&ehk=ypDxZyiMundt2%2f9HKUzf585sGA6lKiOVPJXmuxXxdAg%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'Optima RedTop Car Battery',
      'price': '160 USD',
      'image':
          'https://th.bing.com/th/id/R.bbb14c3bea97aef6849b4300ba3086b2?rik=YQzEv7NkwOGDVA&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f5%2fCar-Battery-PNG-Transparent-Image.png&ehk=ypDxZyiMundt2%2f9HKUzf585sGA6lKiOVPJXmuxXxdAg%3d&risl=&pid=ImgRaw&r=0'
    },
  ];

  List<Map<String, String>> _filteredCarBatteries = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredCarBatteries = List.from(carBatteries);
  }

  // Sorting functionality
  void _sortCarBatteries(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredCarBatteries.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _filteredCarBatteries.sort((a, b) =>
            int.parse(a['price']!.replaceAll(' USD', ''))
                .compareTo(int.parse(b['price']!.replaceAll(' USD', ''))));
      }
    });
  }

  // Search functionality
  void _searchCarBatteries(String query) {
    setState(() {
      _searchQuery = query;
      _filteredCarBatteries = carBatteries
          .where((battery) =>
              battery['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Navigation for Bottom Navigation Bar
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
        leading: GestureDetector(
          onTap: () {
            // Silent back navigation when the back button is tapped
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        title: const Text(
          'Car Battery Details',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchSortBar(),
          _buildCarBatteryGrid(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Search and Sort bar widget
  Widget _buildSearchSortBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: _searchCarBatteries,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Car Batteries',
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
            onSelected: _sortCarBatteries,
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

  // Car battery grid view widget
  Widget _buildCarBatteryGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, child) {
            return GridView.builder(
              itemCount: _filteredCarBatteries.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final battery = _filteredCarBatteries[index];
                final isFavorite = favoriteProvider.isFavorite(battery);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarBatteryDetailsInside(
                          productName: battery['name']!,
                          productPrice: battery['price']!,
                          productImage: battery['image']!,
                        ),
                      ),
                    );
                  },
                  child: _buildCarBatteryCard(
                      battery, isFavorite, favoriteProvider),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Build car battery card widget
  Widget _buildCarBatteryCard(Map<String, String> battery, bool isFavorite,
      FavoriteProvider favoriteProvider) {
    return Card(
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
                child: Image.network(battery['image']!, fit: BoxFit.contain),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  battery['name']!,
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
                  '${battery['price']} USD',
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
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                favoriteProvider.toggleFavorite(battery);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Bottom navigation bar widget
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: _onItemTapped,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
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
