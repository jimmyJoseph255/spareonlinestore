import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'tyredetails.dart';
import 'SpeakerDetailsScreen.dart'; // Import SpeakerDetailsScreen
import 'BrakeDetailsScreen.dart'; // Import BrakeDetailsScreen
import 'SideMirrorDetailsScreen.dart'; // Import SideMirrorDetailsScreen
import 'EngineDetailsScreen.dart'; // Import EngineDetailsScreen (add this)
import 'ClutchDetailsScreen.dart'; // Import ClutchDetailsScreen (updated this)
import 'cart_screen.dart'; // Import CartScreen

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Track the selected index of the BottomNavigationBar
  int _selectedIndex = 0;

  // List of categories
  final categories = [
    'Tyre',
    'Speakers',
    'Brake System',
    'Side Mirror',
    'Engine', // Added Engine category
    'Clutch', // Added Clutch category
  ];

  // Handle the BottomNavigationBar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the Cart Screen when the cart icon is tapped
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length, // Number of categories
          itemBuilder: (context, index) {
            return _categoryCard(context, index);
          },
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Set the selected index
        onTap: _onItemTapped,
        selectedItemColor: Colors.black, // Change selected icon color to black
        unselectedItemColor:
            Colors.black, // Change unselected icon color to black
        backgroundColor: Colors.white, // Handle the tap event
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
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  // Category Card Widget
  Widget _categoryCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (categories[index] == 'Tyre') {
          // Navigate to TyreDetailsScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TyreDetailsScreen()),
          );
        } else if (categories[index] == 'Speakers') {
          // Navigate to SpeakerDetailsScreen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SpeakerDetailsScreen()),
          );
        } else if (categories[index] == 'Brake System') {
          // Navigate to BrakeDetailsScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BrakeDetailsScreen()),
          );
        } else if (categories[index] == 'Side Mirror') {
          // Navigate to SideMirrorDetailsScreen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SideMirrorDetailsScreen()),
          );
        } else if (categories[index] == 'Engine') {
          // Navigate to EngineDetailsScreen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EngineDetailsScreen()),
          );
        } else if (categories[index] == 'Clutch') {
          // Navigate to ClutchDetailsScreen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const ClutchDetailsScreen()), // Navigate to ClutchDetailsScreen
          );
        } else {
          // Show a SnackBar for other categories
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Clicked on ${categories[index]}')),
          );
        }
      },
      child: Card(
        elevation: 4.0,
        color: Colors.white, // Set the card background color to white
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        margin: const EdgeInsets.symmetric(
            vertical: 8.0), // Add margin for spacing between cards
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            categories[index],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
