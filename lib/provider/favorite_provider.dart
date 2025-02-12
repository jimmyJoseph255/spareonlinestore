import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  // List to hold the favorite items
  List<Map<String, String>> _favoriteItems = [];

  // Getter to access the list of favorite items
  List<Map<String, String>> get favoriteItems => _favoriteItems;

  // Method to toggle a product's favorite status
  void toggleFavorite(Map<String, String> product) {
    // Check if the product already exists in the list
    final isFavorite = _favoriteItems.contains(product);

    if (isFavorite) {
      // If it's already a favorite, remove it
      _favoriteItems.remove(product);
    } else {
      // If it's not a favorite, add it
      _favoriteItems.add(product);
    }

    // Notify listeners to update UI when favorites list changes
    notifyListeners();
  }

  // Method to check if a product is in the favorite list
  bool isFavorite(Map<String, String> product) {
    return _favoriteItems.contains(product);
  }

  // Method to clear all favorites
  void clearFavorites() {
    _favoriteItems.clear();
    notifyListeners();
  }

  // Static method to access the provider in any part of the app
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
