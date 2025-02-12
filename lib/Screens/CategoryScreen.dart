import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/SpeakerDetailsScreen.dart'; // Import SpeakerDetailsScreen
import 'package:myproject/Screens/BrakeDetailsScreen.dart'; // Import BrakeDetailsScreen
import 'package:myproject/Screens/SideMirrorDetailsScreen.dart'; // Import SideMirrorDetailsScreen
import 'package:myproject/Screens/EngineDetailsScreen.dart'; // Import EngineDetailsScreen
import 'package:myproject/Screens/ClutchDetailsScreen.dart';
import 'package:myproject/Screens/cart_screen.dart';
import 'package:myproject/Screens/tyredetails.dart'; // Import ClutchDetailsScreen

class CategoryScreen extends StatefulWidget {
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
    'Engine',
    'Clutch',
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
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _categoryCard(context, index);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

  Widget _categoryCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (categories[index] == 'Tyre') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TyreDetailsScreen(),
            ),
          );
        } else if (categories[index] == 'Speakers') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpeakerDetailsScreen(),
            ),
          );
        } else if (categories[index] == 'Brake System') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BrakeDetailsScreen(),
            ),
          );
        } else if (categories[index] == 'Side Mirror') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SideMirrorDetailsScreen(),
            ),
          );
        } else if (categories[index] == 'Engine') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EngineDetailsScreen(),
            ),
          );
        } else if (categories[index] == 'Clutch') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClutchDetailsScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Clicked on ${categories[index]}')),
          );
        }
      },
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
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
