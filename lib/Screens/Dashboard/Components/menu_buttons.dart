import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/category/CategoryScreen.dart';
import 'package:myproject/Screens/widgets/FavoritesScreen.dart';
import 'package:myproject/Screens/Dashboard/refundcreen.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryScreen()),
              );
            },
            child: _menuButton(
                'Category', Icons.menu, Colors.green, CategoryScreen()),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
            child: _menuButton(
                'Favorite', Icons.star_border, Colors.red, FavoritesScreen()),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RefundScreen()),
              );
            },
            child: _menuButton(
                'Refund', Icons.monetization_on, Colors.blue, RefundScreen()),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(String text, IconData icon, Color color, Widget nextPage) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 28,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    );
  }
}
