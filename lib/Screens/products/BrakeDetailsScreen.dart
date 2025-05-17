import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/Dashboard/DashboardScreen.dart';
import 'package:myproject/Screens/account/accountscreen.dart';
import 'package:myproject/Screens/cart/cart_screen.dart';
import 'package:myproject/Screens/widgets/FavoritesScreen.dart';
import 'package:myproject/api_services/getting_data_apiService.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'brakesystemdetailsinside.dart';

class BrakeDetailsScreen extends StatefulWidget {
  const BrakeDetailsScreen({super.key});

  @override
  State<BrakeDetailsScreen> createState() => _BrakeDetailsScreenState();
}

class _BrakeDetailsScreenState extends State<BrakeDetailsScreen> {
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
      _fetchProducts();
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await ApiService.fetchBrakeSystemProducts(token: _token);
      if (products != null && products.isNotEmpty) {
        setState(() {
          _products = products.map<Map<String, dynamic>>((product) {
            String imageUrl = '';
            final imageData = product['image'];
            if (imageData is String) {
              imageUrl = imageData;
            } else if (imageData is Map) {
              imageUrl = imageData['path']?.toString() ??
                  imageData['url']?.toString() ??
                  '';
            }

            imageUrl = imageUrl.replaceAll('\\', '/');

            return {
              'id': product['id']?.toString() ?? '',
              'product_name': product['product_name']?.toString() ?? 'No Name',
              'price': product['price']?.toString() ?? '0',
              'image': imageUrl,
              'car_make': product['car_make'] ?? '',
              'car_model': product['car_model'] ?? '',
              'car_year': product['car_year'] ?? '',
              'category_part': product['category_part'] ?? '',
              'brake_type': product['brake_type'] ?? '',
              'position': product['position'] ?? '',
              'pad_material': product['pad_material'] ?? '',
              'rotor_diameter_mm': product['rotor_diameter_mm'] ?? '',
              'rotor_thickness_mm': product['rotor_thickness_mm'] ?? '',
              'piston_count': product['piston_count'] ?? '',
              'is_abs_compatible': product['is_abs_compatible'] ?? '',
              'brake_fluid_type': product['brake_fluid_type'] ?? '',
              'stock': product['stock'] ?? '',
            };
          }).toList();

          _filteredProducts = List.from(_products);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Fetch Error: $e");
      setState(() => _isLoading = false);
    }
  }

  void _sortProducts(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _filteredProducts
            .sort((a, b) => a['product_name'].compareTo(b['product_name']));
      } else if (criteria == 'Price') {
        _filteredProducts.sort((a, b) {
          final priceA = double.tryParse(a['price']) ?? 0;
          final priceB = double.tryParse(b['price']) ?? 0;
          return priceA.compareTo(priceB);
        });
      }
    });
  }

  void _searchProduct(String query) {
    setState(() {
      _filteredProducts = _products.where((product) {
        final name = product['product_name'].toLowerCase();
        final price = product['price'];
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Brake System Details',
            style: GoogleFonts.lato(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _filteredProducts.isEmpty
              ? Center(
                  child: Text('No Brake Systems Found',
                      style: TextStyle(color: Colors.white, fontSize: 16)))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search Brake Systems',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none),
                              ),
                              onChanged: _searchProduct,
                            ),
                          ),
                          SizedBox(width: 10),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.sort, color: Colors.white),
                            onSelected: _sortProducts,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 'Alphabetical',
                                  child: Text('Sort A-Z')),
                              PopupMenuItem(
                                  value: 'Price', child: Text('Sort by Price')),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Consumer<FavoriteProvider>(
                          builder: (context, favoriteProvider, child) {
                            return GridView.builder(
                              itemCount: _filteredProducts.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemBuilder: (context, index) {
                                final product = _filteredProducts[index];
                                final isFavorite = favoriteProvider.isFavorite({
                                  'product_name': product['product_name'],
                                  'price': product['price'],
                                  'image': product['image'],
                                  'id': product['id'],
                                });

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BrakeSystemDetailsInside(
                                          product: product,
                                          token: _token,
                                          productName: '',
                                          productPrice: '',
                                          productImage: '',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color:
                                        _cardColors[index % _cardColors.length],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            product['image'],
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(Icons.broken_image,
                                                        size: 50,
                                                        color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: Text(product['product_name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                              textAlign: TextAlign.center),
                                        ),
                                        Text('${product['price']} USD',
                                            style: TextStyle(
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.w600)),
                                        IconButton(
                                          icon: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red),
                                          onPressed: () {
                                            favoriteProvider.toggleFavorite({
                                              'product_name':
                                                  product['product_name'],
                                              'price': product['price'],
                                              'image': product['image'],
                                              'id': product['id'],
                                            });
                                          },
                                        )
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xFF43A4F3)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
              backgroundColor: Color(0xFF43A4F3)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
              backgroundColor: Color(0xFF43A4F3)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
              backgroundColor: Color(0xFF43A4F3)),
        ],
      ),
    );
  }
}
