import 'package:flutter/material.dart';
import 'package:myproject/Screens/cart/cart_screen.dart';
import 'package:myproject/Screens/account/accountscreen.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 91, 141, 182),
      currentIndex: selectedIndex,
      onTap: (index) {
        onItemTapped(index);

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
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color.fromARGB(255, 75, 167, 241),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: Color.fromARGB(255, 67, 164, 243),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Add to Cart',
          backgroundColor: Color.fromARGB(255, 67, 164, 243),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
          backgroundColor: Color.fromARGB(255, 67, 164, 243),
        ),
      ],
    );
  }
}
