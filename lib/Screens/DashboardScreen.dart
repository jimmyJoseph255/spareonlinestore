import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/refundcreen.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'CategoryScreen.dart';
import 'cart_screen.dart';
import 'accountscreen.dart';
import 'NotificationsScreen.dart';
import 'BrakeDetailsScreen.dart';
import 'EngineDetailsScreen.dart';
import 'FavoritesScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedIndex = 0;
  //Set<Map<String, String>> favorites = {}; // Use a Set to store favorites
  List<Map<String, String>> _favorites = [];

  final List<String> _carouselImages = [
    'lib/images/Engine.png', // Engine Product
    'lib/images/Brake.png', // Brake Product
    'lib/images/Engine.png', // Tyre Product
    'lib/images/Brake.png', // Air Filter Product
  ];

  final List<String> _carouselTexts = [
    'Shop Tyres and \ngenuine parts \nEnjoy Delivery',
    'Get your Brakes \nchecked and save \nmore',
    'Find the best Tyres \nfor your vehicle now!',
    'Replace your Air Filters \nwith the best deals!',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = FavoriteProvider.of(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _buildAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              _buildCarousel(),
              const SizedBox(height: 40),
              _buildMenuButtons(),
              const SizedBox(height: 20),
              _buildSuggestionsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          }
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Add to Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Welcome\nJimmy',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_active_outlined,
                      color: Colors.black, size: 28),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountScreen()),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('lib/images/profile.jpg'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _menuButton('Category', Icons.menu, Colors.green, CategoryScreen()),
          _menuButton(
              'Favorite', Icons.star_border, Colors.red, FavoritesScreen()),
          _menuButton(
              'Refund', Icons.monetization_on, Colors.blue, RefundScreen()),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.25,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
      ),
      items: [
        {
          'image': 'lib/images/Brake.png',
          'title': 'Boda Stress!',
          'text': 'High-Quality Brakes',
          'buttonText': 'Order Now',
          'screen': BrakeDetailsScreen(),
        },
        {
          'image': 'lib/images/Engine.png',
          'title': '',
          'text': 'Powerful Engines',
          'price': '\Tsh.500,000',
          'buttonText': 'Courier Now',
          'screen': EngineDetailsScreen(),
        },
        {
          'image': 'lib/images/Engine.png',
          'title': '',
          'text': 'Durable Tyres',
          'buttonText': 'Add to Cart',
          'screen': EngineDetailsScreen(),
        },
        {
          'image': '',
          'title': '',
          'text': '',
          'buttonText': '',
          'rightImage': 'lib/images/deliveryman.png',
          'adText': 'Reliable Delivery at Your Doorstep',
          'screen': null,
        }
      ].map((Map<String, dynamic> item) {
        return GestureDetector(
          onTap: () {
            if (item['screen'] != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item['screen']),
              );
            }
          },
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 252, 7, 101),
                      Color.fromARGB(255, 34, 34, 34),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.3, 0.9],
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (item['title']!.isNotEmpty)
                              Text(
                                item['title']!,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                              ),
                            const SizedBox(height: 5),
                            Text(
                              item['text']!,
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            if (item['text'] == 'Powerful Engines' &&
                                item['price'] != null)
                              Text(
                                item['price']!,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                              ),
                            const SizedBox(height: 60),
                            if (item['buttonText'] != null &&
                                item['buttonText']!.isNotEmpty)
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  item['buttonText']!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          if (item['image'] != null &&
                              item['image']!.isNotEmpty)
                            Positioned(
                              left: 12,
                              top: 30,
                              child: Image.asset(
                                item['image']!,
                                height: 150,
                                width: 220,
                              ),
                            ),
                          if (item['rightImage'] != null &&
                              item['rightImage']!.isNotEmpty)
                            Positioned(
                              left: 12,
                              top: 30,
                              child: Image.asset(
                                item['rightImage']!,
                                height: 150,
                                width: 220,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _menuButton(String text, IconData icon, Color color, Widget nextPage) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 28,
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // Builds a horizontal list of suggested items
  Widget _buildSuggestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Suggestions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Center(
                  child: _suggestionItem('lib/images/Engine.png', 'Engine',
                      '-19%', EngineDetailsScreen())),
              Center(
                  child: _suggestionItem('lib/images/Brake.png', 'Brake Discs',
                      '-50%', BrakeDetailsScreen())),
              Center(
                  child: _suggestionItem('lib/images/Brake.png', 'Brake Discs',
                      '-50%', BrakeDetailsScreen())),
            ],
          ),
        ),
      ],
    );
  }

  // Generic suggestion item widget
  Widget _suggestionItem(
      String imagePath, String title, String discount, Widget detailsScreen) {
    bool isFavorite = _favorites.any((item) => item['title'] == title);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => detailsScreen),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  discount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
