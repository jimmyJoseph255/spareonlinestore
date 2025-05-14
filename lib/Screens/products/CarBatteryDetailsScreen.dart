import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/Dashboard/DashboardScreen.dart';
import 'package:myproject/Screens/account/accountscreen.dart';
import 'package:myproject/Screens/cart/cart_screen.dart';
import 'package:myproject/Screens/products/CarBatteryDetailsInside.dart';
import 'package:myproject/Screens/widgets/FavoritesScreen.dart';
import 'package:myproject/api_services/getting_data_apiService.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarBatteryDetailsScreen extends StatefulWidget {
  const CarBatteryDetailsScreen({super.key});

  @override
  State<CarBatteryDetailsScreen> createState() =>
      _CarBatteryDetailsScreenState();
}

class _CarBatteryDetailsScreenState extends State<CarBatteryDetailsScreen> {
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  bool _isLoading = true;
  String? _token;

  final List<Color> _cardColors = [
    Colors.yellow,
    Color(0xFFFF00D4),
    Color(0xFFA19AA7),
    Color(0xFF48FF00),
    Color(0xFFFF9900),
    Color(0xFFD900FF),
    Color(0xFF00ECD9),
    Color(0xFFB6285A),
  ];

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final box = GetStorage();
    _token = box.read('token');

    if (_token == null) {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
    }

    if (_token != null) {
      print('Token loaded in CarBatteryDetailsScreen: $_token');
      _fetchProducts();
    } else {
      print('No token found in CarBatteryDetailsScreen');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await ApiService.fetchCarBatteryProducts(token: _token);
      print('Fetched car battery products: $products');

      setState(() {
        _products = products.map<Map<String, dynamic>>((product) {
          String imageUrl = '';

          final imageData = product['image'];
          if (imageData is String) {
            if (imageData.trim().startsWith('{')) {
              try {
                final decoded = jsonDecode(imageData);
                if (decoded is Map && decoded.containsKey('path')) {
                  imageUrl = decoded['path'] ?? '';
                }
              } catch (e) {
                print('Failed to decode image JSON: $e');
                imageUrl = imageData;
              }
            } else {
              imageUrl = imageData;
            }
          } else if (imageData is Map) {
            imageUrl = imageData['path']?.toString() ??
                imageData['url']?.toString() ??
                '';
          }

          // Replace backslashes
          imageUrl = imageUrl.replaceAll('\\', '/');

          print('Processed image URL: $imageUrl');

          return {
            'name': product['name']?.toString() ?? 'No Name',
            'price': product['price']?.toString() ?? '0',
            'image': imageUrl,
            'id': product['id']?.toString() ?? '',
          };
        }).toList();

        _filteredProducts = List.from(_products);
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching car battery products: $e');
      setState(() => _isLoading = false);
    }
  }

  String _constructImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;

    final cleanPath =
        imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;

    return 'https://sparefasta.co.tz/storage/$cleanPath';
  }

  void _sortProducts(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredProducts.sort((a, b) =>
            (a['name'] ?? 'No Name').compareTo(b['name'] ?? 'No Name'));
      } else if (criteria == 'Price') {
        _filteredProducts.sort((a, b) {
          final priceA = double.tryParse(a['price'] ?? '0') ?? 0;
          final priceB = double.tryParse(b['price'] ?? '0') ?? 0;
          return priceA.compareTo(priceB);
        });
      }
    });
  }

  void _searchProduct(String query) {
    setState(() {
      _filteredProducts = _products.where((product) {
        final name = (product['name'] ?? '').toLowerCase();
        final price = product['price'] ?? '';
        return name.contains(query.toLowerCase()) || price.contains(query);
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CartScreen()));
    } else if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AccountScreen()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF43A4F3),
      appBar: AppBar(
        backgroundColor: Color(0xFF43A4F3),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Silent back navigation when the back button is tapped
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text(
          'Car Battery Details',
          style: GoogleFonts.lato(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search Car Batteries',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onChanged: _searchProduct,
                        ),
                      ),
                      SizedBox(width: 10),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.sort),
                        onSelected: _sortProducts,
                        color: Colors.white,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 'Alphabetical', child: Text('Sort A-Z')),
                          PopupMenuItem(
                              value: 'Price', child: Text('Sort by Price')),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Consumer<FavoriteProvider>(
                      builder: (context, favoriteProvider, child) {
                        return GridView.builder(
                          itemCount: _filteredProducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            final imageUrl =
                                _constructImageUrl(product['image'] ?? '');
                            final favoriteProduct = {
                              'name': (product['name'] ?? 'No Name').toString(),
                              'price': (product['price'] ?? '0').toString(),
                              'image': (product['image'] ?? '').toString(),
                              'id': (product['id'] ?? '').toString(),
                            };
                            final isFavorite =
                                favoriteProvider.isFavorite(favoriteProduct);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CarBatteryDetailsInside(
                                      productName: product['name'] ?? 'No Name',
                                      productPrice: '${product['price']} USD',
                                      productImage: product['image'] ?? '',
                                      token: _token,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 2,
                                color: _cardColors[index % _cardColors.length],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey[200],
                                                child: Center(
                                                  child: Icon(
                                                      Icons.broken_image,
                                                      size: 10,
                                                      color: Colors.grey),
                                                ),
                                              );
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Text(
                                            '${product['price']} USD',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          favoriteProvider
                                              .toggleFavorite(favoriteProduct);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFF43A4F3),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            backgroundColor: Color(0xFF43A4F3),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Color(0xFF43A4F3),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Color(0xFF43A4F3),
          ),
        ],
      ),
    );
  }
}
