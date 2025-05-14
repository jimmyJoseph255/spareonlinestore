import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0072FF), Color(0xFF16AFDA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                elevation: 3,
                title: Text(
                  "Favorites Screen",
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                backgroundColor: Colors.transparent,
                leading: GestureDetector(
                  onTap: () {
                    // Silent back navigation when the back button is tapped
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                centerTitle: true,
              ),
              Expanded(
                child: Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, child) {
                    final favorites = favoriteProvider.favoriteItems;

                    return favorites.isEmpty
                        ? Center(
                            child: Text(
                            "No favorites yet!",
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ))
                        : ListView.builder(
                            itemCount: favorites.length,
                            itemBuilder: (context, index) {
                              final tyre = favorites[index];
                              return Card(
                                color: const Color.fromARGB(255, 255, 251, 0),
                                elevation: 5,
                                margin: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image.network(tyre['image']!),
                                  title: Text(
                                    tyre['name']!,
                                    style: GoogleFonts.lato(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${tyre['price']} USD',
                                    style: GoogleFonts.lato(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      favoriteProvider.toggleFavorite(tyre);
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
