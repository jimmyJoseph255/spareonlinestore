import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myproject/Screens/LoginAndSignUp/CustomerLoginScreen.dart';
import 'package:myproject/Screens/Dashboard/DashboardScreen.dart';
import 'package:myproject/Screens/LoginAndSignUp/SellerLoginPageScreen.dart';

import 'package:myproject/Screens/cart/cart_screen.dart';

import 'package:myproject/Screens/orders/OrderScreen.dart';
import 'package:myproject/Screens/account/AccountInformationScreen.dart';
import 'package:myproject/Screens/account/AccountSecurityScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HelpScreen.dart';

class SellerAccountScreen extends StatefulWidget {
  const SellerAccountScreen({super.key});

  @override
  _SellerAccountScreenState createState() => _SellerAccountScreenState();
}

class _SellerAccountScreenState extends State<SellerAccountScreen> {
  int _currentIndex = 3; // Set the initial index to the 'Account' section

  // Handle navigation based on bottom navigation selection
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else if (index == 1) {
      // Handle Search navigation
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    } else if (index == 3) {
      // Already on Profile screen, no navigation required
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        title: Text(
          "Account",
          style: TextStyle(
            color: Colors.white, // Change to white
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardItem(
              icon: Icons.shopping_bag,
              title: 'Orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrdersScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildCardItem(
              icon: Icons.account_circle,
              title: 'Account Information',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountInformationScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildCardItem(
              icon: Icons.security,
              title: 'Security and Settings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountSecurityScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildCardItem(
              icon: Icons.help,
              title: 'Help',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildCardItem(
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () async {
                // Clear token from GetStorage
                final box = GetStorage();
                await box.remove('token');

                // Clear token from SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('auth_token');

                // Then navigate to login screen and remove all previous routes
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => Sellerloginpagescreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _currentIndex, // Set the current index to highlight the 'Account' section
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Colors.blueAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: const Color.fromARGB(255, 67, 164, 243),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: const Color.fromARGB(255, 67, 164, 243),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Add to Cart',
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

  Widget _buildCardItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color.fromARGB(255, 58, 58, 58), // Set card color to yellow
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white, // Change to white
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
