import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Map<String, String>> favoriteItems;

  const FavoritesScreen({super.key, required this.favoriteItems});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Map<String, String>> _favoriteItems;

  @override
  void initState() {
    super.initState();
    _favoriteItems = List.from(widget.favoriteItems);
  }

  @override
  void didUpdateWidget(FavoritesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.favoriteItems != widget.favoriteItems) {
      setState(() {
        _favoriteItems = List.from(widget.favoriteItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: _favoriteItems.isEmpty
          ? const Center(child: Text('No favorite items yet!'))
          : ListView.builder(
              itemCount: _favoriteItems.length,
              itemBuilder: (context, index) {
                final product = _favoriteItems[index];
                return ListTile(
                  title: Text(product['name']!),
                  subtitle: Text('${product['price']} USD'),
                  leading: Image.network(product['image']!),
                );
              },
            ),
    );
  }
}
