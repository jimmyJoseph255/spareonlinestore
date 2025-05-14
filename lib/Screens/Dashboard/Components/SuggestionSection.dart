import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/Dashboard/Components/SuggestionItem.dart';
import 'package:myproject/Screens/products/BrakeDetailsScreen.dart';
import 'package:myproject/Screens/products/EngineDetailsScreen.dart';

class SuggestionSection extends StatefulWidget {
  const SuggestionSection({super.key});

  @override
  State<SuggestionSection> createState() => _SuggestionSectionState();
}

class _SuggestionSectionState extends State<SuggestionSection> {
  final List<Map<String, String>> _favorites = [];

  void toggleFavorite(String title) {
    setState(() {
      if (_favorites.any((item) => item['title'] == title)) {
        _favorites.removeWhere((item) => item['title'] == title);
      } else {
        _favorites.add({'title': title});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Suggestions',
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SuggestionItem(
                imagePath: 'lib/images/Engine.png',
                title: 'Engine',
                discount: '-19%',
                detailsScreen: const EngineDetailsScreen(),
                isFavorite: _favorites.any((item) => item['title'] == 'Engine'),
                onFavoriteToggle: () => toggleFavorite('Engine'),
              ),
              SuggestionItem(
                imagePath: 'lib/images/Brake.png',
                title: 'Brake Discs',
                discount: '-50%',
                detailsScreen: const BrakeDetailsScreen(),
                isFavorite:
                    _favorites.any((item) => item['title'] == 'Brake Discs'),
                onFavoriteToggle: () => toggleFavorite('Brake Discs'),
              ),
              SuggestionItem(
                imagePath: 'lib/images/Brake.png',
                title: 'Brake Discs',
                discount: '-50%',
                detailsScreen: const BrakeDetailsScreen(),
                isFavorite:
                    _favorites.any((item) => item['title'] == 'Brake Discs'),
                onFavoriteToggle: () => toggleFavorite('Brake Discs'),
              ),
              SuggestionItem(
                imagePath: 'lib/images/Brake.png',
                title: 'Brake Discs',
                discount: '-50%',
                detailsScreen: const BrakeDetailsScreen(),
                isFavorite:
                    _favorites.any((item) => item['title'] == 'Brake Discs'),
                onFavoriteToggle: () => toggleFavorite('Brake Discs'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
