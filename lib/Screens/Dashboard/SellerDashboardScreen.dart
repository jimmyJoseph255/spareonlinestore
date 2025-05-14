import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:myproject/Screens/Selleraddingproducts/SellerChooseProducts.dart';
import 'package:myproject/Screens/account/SellerAccountInformation.dart';
import 'package:myproject/Screens/products/SellerBrakeSystemDetailsScreen.dart';
import 'package:myproject/Screens/products/SellerCarTyresDetailsScreen.dart';
import 'package:myproject/Screens/products/SellerClutchDetailsScreen.dart';
import 'package:myproject/Screens/products/SellerEngineDetailsScreen.dart';
import 'package:myproject/Screens/LoginAndSignUp/SellerLoginPageScreen.dart';
import 'package:myproject/Screens/orders/SellerOrdersScreen.dart';

import 'package:myproject/Screens/Dashboard/SellerSearchScreen.dart';

import 'package:myproject/Screens/widgets/SellerDeliveryAgentScreen.dart';
import 'package:myproject/Screens/widgets/SellerFeedbackScreen.dart';
import 'package:myproject/Screens/widgets/SellerReportScreen.dart';
import 'package:myproject/Screens/Dashboard/Components/Notification/SellerNotificationsScreen.dart';
import 'package:myproject/Screens/products/SellerSideMirrorsDetailsScreen.dart';
import 'package:myproject/Screens/products/SellerSpeakersDetailsScreen.dart';
import 'package:myproject/Screens/account/selleraccountscreen.dart';

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
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 67, 164, 243),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hi, Noel',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
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
                              color: Color.fromARGB(255, 255, 255, 255)),
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
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('lib/images/profile.jpg'),
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the SellerAccountInformation screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SellerAccountScreen(),
                              ),
                            );
                          },
                        ),
                      )
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
                color: Color.fromARGB(
                    255, 67, 164, 243), // Set background color to white
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 238, 0),
                      ), // Retain header color
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SellerDashboardScreen()),
                        );
                      },
                      child: ListTile(
                        leading:
                            const Icon(Icons.dashboard, color: Colors.white),
                        title: const Text('Dashboard',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    // Dashboard Row with Icon and Text
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellerOrdersScreen()),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.shopping_cart,
                            color: Colors.white),
                        title: const Text('Orders',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SellerDeliveryAgentScreen()),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.delivery_dining,
                            color: Colors.white),
                        title: const Text('Delivery Agent',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellerFeedbackScreen()),
                        );
                      },
                      child: ListTile(
                        leading:
                            const Icon(Icons.feedback, color: Colors.white),
                        title: const Text('Feedback',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellerReportScreen()),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.report, color: Colors.white),
                        title: const Text('Report',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SellerNotificationsScreen()),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.notifications,
                            color: Colors.white),
                        title: const Text('Notification',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Sellerloginpagescreen()),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.logout, color: Colors.white),
                        title: const Text('Logout',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Color.fromARGB(255, 75, 167, 241),
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
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  // Function to build menu items with icons and text
  Widget _buildMenuItem(IconData icon, String title, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: ListTile(
        leading: Icon(icon, color: Colors.black), // Change to grey color
        title: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 67, 164, 243), // Set background color of HomeScreen to white
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  'Add Products',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Color.fromARGB(255, 58, 243, 33),
                    size: 40, // Adjust the size as needed
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductScreen(),
                      ),
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
        color:
            const Color.fromARGB(255, 255, 251, 0), // Set card color to white
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
