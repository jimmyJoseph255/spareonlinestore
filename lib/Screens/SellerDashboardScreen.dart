import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:myproject/Screens/AddProductScreen.dart';
import 'package:myproject/Screens/SellerAccountInformation.dart';
import 'package:myproject/Screens/SellerBrakeSystemDetailsScreen.dart';
import 'package:myproject/Screens/SellerCarTyresDetailsScreen.dart';
import 'package:myproject/Screens/SellerClutchDetailsScreen.dart';
import 'package:myproject/Screens/SellerEngineDetailsScreen.dart';
import 'package:myproject/Screens/SellerSearchScreen.dart';
import 'package:myproject/Screens/SellerSideMirrorsDetailsScreen.dart';
import 'package:myproject/Screens/SellerSpeakersDetailsScreen.dart';
import 'package:myproject/Screens/SellerLoginPageScreen.dart';
import 'package:myproject/Screens/SellerOrdersScreen.dart';
import 'package:myproject/Screens/SellerDeliveryAgentScreen.dart';
import 'package:myproject/Screens/SellerFeedbackScreen.dart';
import 'package:myproject/Screens/SellerReportScreen.dart';
import 'package:myproject/Screens/SellerNotificationsScreen.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  int _selectedIndex = 0; // Default selected tab index
  int notificationCount = 3; // Set the initial notification count to 3

  // List of screens for each BottomNavigationBar item
  final List<Widget> _screens = [
    const HomeScreen(), // Home screen (current dashboard)
    const SellerSearchScreen(), // Search screen
    const SellerAccountInformation(), // Account screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hi, Noel',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: badges.Badge(
                          badgeContent: Text(
                            notificationCount.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            badgeColor: Colors.red, // Red badge color
                          ),
                          child: const Icon(Icons.notifications,
                              color: Colors.black),
                        ),
                        onPressed: () {
                          setState(() {
                            notificationCount = 0; // Reset notification count
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SellerNotificationsScreen()),
                          );
                        },
                      ),
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('lib/images/profile.jpg'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
      drawer: _selectedIndex == 0
          ? Drawer(
              child: Container(
                // Wrap the Drawer content with a Container
                color: Colors.white, // Set background color to white
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                          color:
                              const Color(0xFFED1CF1)), // Retain header color
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('lib/images/profile.jpg'),
                          ),
                          const SizedBox(width: 15),
                          const Text('Hi, Noel',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // Dashboard Row with Icon and Text
                    ListTile(
                      leading: const Icon(Icons.dashboard, color: Colors.grey),
                      title: const Text('Dashboard',
                          style: TextStyle(fontSize: 16)),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SellerDashboardScreen()),
                        );
                      },
                    ),
                    // Other Menu Items with Icons
                    _buildMenuItem(Icons.shopping_cart, 'Orders', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellerOrdersScreen()),
                      );
                    }),
                    _buildMenuItem(Icons.delivery_dining, 'Delivery Agent', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SellerDeliveryAgentScreen()),
                      );
                    }),
                    _buildMenuItem(Icons.feedback, 'Feedback', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellerFeedbackScreen()),
                      );
                    }),
                    _buildMenuItem(Icons.report, 'Report', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellerReportScreen()),
                      );
                    }),
                    _buildMenuItem(Icons.notifications, 'Notifications', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SellerNotificationsScreen()),
                      );
                    }),
                    // Updated Logout menu item
                    _buildMenuItem(Icons.logout, 'Logout', () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SellerLoginPageScreen()),
                      );
                    }),
                  ],
                ),
              ),
            )
          : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  // Function to build menu items with icons and text
  Widget _buildMenuItem(IconData icon, String title, [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey), // Change to grey color
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap ?? () {},
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Set background color of HomeScreen to white
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  'Products',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const Spacer(),
                IconButton(
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProductScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildProductCard(context, 'Car Tyres'),
                _buildProductCard(context, 'Speakers'),
                _buildProductCard(context, 'Side Mirrors'),
                _buildProductCard(context, 'Clutch'),
                _buildProductCard(context, 'Brake System'),
                _buildProductCard(context, 'Engine'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String productName) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        color: Colors.white, // Set card color to white
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {
            // Navigate to product details based on product name
            Widget screen;
            switch (productName) {
              case 'Car Tyres':
                screen = const SellerCarTyresDetailsScreen();
                break;
              case 'Speakers':
                screen = const SellerSpeakersDetailsScreen();
                break;
              case 'Side Mirrors':
                screen = const SellerSideMirrorsDetailsScreen();
                break;
              case 'Clutch':
                screen = const SellerClutchDetailsScreen();
                break;
              case 'Brake System':
                screen = const SellerBrakeSystemDetailsScreen();
                break;
              case 'Engine':
                screen = const SellerEngineDetailsScreen();
                break;
              default:
                return;
            }
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
          child: ListTile(
            title: Text(productName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Add functionality for deleting the product
              },
            ),
          ),
        ),
      ),
    );
  }
}
