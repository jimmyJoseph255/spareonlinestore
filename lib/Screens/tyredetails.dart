import 'package:flutter/material.dart';
import 'package:myproject/Screens/DashboardScreen.dart';
import 'package:myproject/Screens/FavoritesScreen.dart';
import 'package:myproject/Screens/accountscreen.dart';
import 'cart_screen.dart';
import 'tyredetailsinside.dart';

class TyreDetailsScreen extends StatefulWidget {
  const TyreDetailsScreen({super.key});

  @override
  State<TyreDetailsScreen> createState() => _TyreDetailsScreenState();
}

class _TyreDetailsScreenState extends State<TyreDetailsScreen> {
  final List<Map<String, String>> products = const [
    {
      'name': 'Pirelli Cinturato P7',
      'price': '42500',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Michelin Pilot Sport 4',
      'price': '300',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Bridgestone Turanza T005',
      'price': '250',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Bridgestone Turanza T005',
      'price': '20',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Bridgestone Turanza T005',
      'price': '10',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
    {
      'name': 'Bridgestone Turanza T005',
      'price': '250',
      'image':
          'https://www.goodyear.eu/en_gb/consumer/learn/understandingyourtyre/_jcr_content/root/container/container_34560/image_107003403.coreimg.png/1610364173421/goodyear-vector4seasons-gen3-suv--view-3-3-4-30-deg-lr-shadow-small-resize.png'
    },
  ];

  List<Map<String, String>> _sortedProducts = [];
  final Set<Map<String, String>> _favoriteItems = {};

  @override
  void initState() {
    super.initState();
    _sortedProducts = List.from(products); // Create a mutable copy of products
  }

  void _sortProducts(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _sortedProducts.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (criteria == 'Price') {
        _sortedProducts.sort(
            (a, b) => int.parse(a['price']!).compareTo(int.parse(b['price']!)));
      }
    });
  }

  void _toggleFavorite(Map<String, String> product) {
    setState(() {
      if (_favoriteItems.contains(product)) {
        _favoriteItems.remove(product);
      } else {
        _favoriteItems.add(product);
      }
    });
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CartScreen()));
    } else if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()));
    } else if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AccountScreen()));
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FavoritesScreen(favoriteItems: _favoriteItems.toList()),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Tyre Details',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Tyres',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: _sortProducts,
                  color: Colors.white,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 'Alphabetical', child: Text('Sort A-Z')),
                    const PopupMenuItem(
                        value: 'Price', child: Text('Sort by Price')),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: _sortedProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = _sortedProducts[index];
                  final isFavorite = _favoriteItems.contains(product);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TyreDetailsInside(
                            productName: product['name']!,
                            productPrice: product['price']!,
                            productImage: product['image']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Image.network(product['image']!,
                                      fit: BoxFit.contain)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product['name']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  '${product['price']} USD',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 8,
                            right: 2,
                            child: IconButton(
                              icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red),
                              onPressed: () => _toggleFavorite(product),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
