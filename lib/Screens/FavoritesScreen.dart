import 'package:flutter/material.dart';
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
                title: const Text("Favorites Screen",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.transparent,
              ),
              Expanded(
                child: Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, child) {
                    final favorites = favoriteProvider.favoriteItems;

                    return favorites.isEmpty
                        ? const Center(
                            child: Text("No favorites yet!",
                                style: TextStyle(color: Colors.white)))
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
                                  title: Text(tyre['name']!),
                                  subtitle: Text('${tyre['price']} USD'),
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
