import 'package:flutter/material.dart';
import 'CategoryScreen.dart';
import 'cart_screen.dart'; // Import CartScreen
// Import the ProfileScreen

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            // Username Section
            Text(
              'Username',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Jimmy',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40), // Space between Username and Email sections

            // Email Section
            Text(
              'Email',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'jimmyjoseph02@gmail.com',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40), // Space between Email and Phone sections

            // Phone Number Section
            Text(
              'Phone Number',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '0710661252',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 40), // Space between Phone Number and Password sections

            // Password Section
            Text(
              'Password',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '**************',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Add the BottomNavigationBar here
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Highlight the 'Account' section
        onTap: (index) {
          // Handle navigation
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.blueAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.white,
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
}
