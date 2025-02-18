import 'dart:math'; // Import the math library for Random

import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/FavoritesScreen.dart';
import 'package:myproject/Screens/accountscreen.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';
import 'speakerdetailsinside.dart';

class SpeakerDetailsScreen extends StatefulWidget {
  const SpeakerDetailsScreen({super.key});

  @override
  State<SpeakerDetailsScreen> createState() => _SpeakerDetailsScreenState();
}

class _SpeakerDetailsScreenState extends State<SpeakerDetailsScreen> {
  final List<Map<String, String>> speakers = const [
    {
      'name': 'JBL Flip 5',
      'price': '150',
      'image':
          'https://th.bing.com/th/id/R.f19761431de46d6175de8fa4b748cc0a?rik=bCE9qwf2mKHjxA&pid=ImgRaw&r=0'
    },
    {
      'name': 'Sony SRS-XB43',
      'price': '200',
      'image':
          'https://pluspng.com/img-png/car-audio-png-kenwood-car-audio-580.png'
    },
    {
      'name': 'ABose SoundLink',
      'price': '250',
      'image':
          'https://th.bing.com/th/id/R.f19761431de46d6175de8fa4b748cc0a?rik=bCE9qwf2mKHjxA&pid=ImgRaw&r=0'
    },
    {
      'name': 'Bose SoundLink',
      'price': '50',
      'image':
          'https://th.bing.com/th/id/R.f19761431de46d6175de8fa4b748cc0a?rik=bCE9qwf2mKHjxA&pid=ImgRaw&r=0'
    },
    {
      'name': 'Bose SoundLink',
      'price': '20',
      'image':
          'https://th.bing.com/th/id/R.f19761431de46d6175de8fa4b748cc0a?rik=bCE9qwf2mKHjxA&pid=ImgRaw&r=0'
    },
    {
      'name': 'Bose SoundLink',
      'price': '20',
      'image':
          'https://pngpix.com/images/hd/vehicle-subwoofer-png-gix-34ja8lvnwhu1izo9.jpg'
    },
    {
      'name': 'Bose SoundLink',
      'price': '20',
      'image':
          'https://th.bing.com/th/id/R.fb7bad61b6bd7cf68a50d959b6466b06?rik=BqlFx7trAXDpeg&riu=http%3a%2f%2fpngimg.com%2fuploads%2faudio_speakers%2faudio_speakers_PNG11120.png&ehk=Db5CVCQcS0%2fH%2bEytk9x%2bZyfTcBlnhNp0KgeHAmdgeKs%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'name': 'Bose SoundLink',
      'price': '20',
      'image':
          'https://pngpix.com/images/hd/vehicle-subwoofer-png-gix-34ja8lvnwhu1izo9.jpg'
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

  List<Map<String, String>> _filteredSpeakers = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredSpeakers = List.from(speakers);
  }

  void _sortSpeakers(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredSpeakers.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _filteredSpeakers.sort(
            (a, b) => int.parse(a['price']!).compareTo(int.parse(b['price']!)));
      }
    });
  }

  void _searchSpeakers(String query) {
    setState(() {
      _searchQuery = query;
      _filteredSpeakers = speakers
          .where((speaker) =>
              speaker['name']!.toLowerCase().contains(query.toLowerCase()))
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FavoritesScreen()));
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
          'Speaker Details',
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
                      hintText: 'Search Speakers',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onChanged: _searchSpeakers,
                  ),
                ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: _sortSpeakers,
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
                    itemCount: _filteredSpeakers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final speaker = _filteredSpeakers[index];
                      final isFavorite = favoriteProvider.isFavorite(speaker);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpeakerDetailsInside(
                                productName: speaker['name']!,
                                productPrice: speaker['price']!,
                                productImage: speaker['image']!,
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
                                    child: Image.network(speaker['image']!,
                                        fit: BoxFit.contain),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      speaker['name']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      '${speaker['price']} USD',
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
                                    favoriteProvider.toggleFavorite(speaker);
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
        backgroundColor: Color.fromARGB(255, 67, 164, 243),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 67, 164, 243)),
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
