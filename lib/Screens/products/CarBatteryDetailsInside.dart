import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/cart/cart_screen.dart';
import 'package:myproject/Screens/widgets/shared_data.dart';

class CarBatteryDetailsInside extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  const CarBatteryDetailsInside({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    String? token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        'Car Battery Details',
        style: GoogleFonts.lato(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          // Silent back navigation when the back button is tapped
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        _buildProductName(),
        const SizedBox(height: 10),
        _buildProductImage(),
        const SizedBox(height: 20),
        _buildProductPrice(),
        const Spacer(),
        _buildAddToCartButton(context),
      ],
    );
  }

  Widget _buildProductName() {
    return Text(
      productName,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProductPrice() {
    return Text(
      'Price: $productPrice',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 247, 201, 0),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => _handleAddToCart(context),
          child: const Text(
            'Add to Cart',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _handleAddToCart(BuildContext context) {
    cartItems.add({
      'name': productName,
      'price': productPrice,
      'image': productImage,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item added to cart!'),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartScreen()),
    );
  }

  Widget _buildProductImage() {
    if (productImage.startsWith('http')) {
      return _buildNetworkImage(productImage);
    }

    final String baseUrl = 'https://sparefasta.co.tz';
    final String imagePath =
        productImage.startsWith('/') ? productImage : '/$productImage';
    final String fullImageUrl = '$baseUrl$imagePath';

    return _buildNetworkImage(fullImageUrl);
  }

  Widget _buildNetworkImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.1),
      ),
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          height: 200,
          width: 200,
          fit: BoxFit.contain,
          headers: const {
            'Accept': 'image/*',
          },
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Image load error: $error for URL: $imageUrl');
            return Container(
              height: 200,
              width: 200,
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text(
                    'Image not available',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              height: 200,
              width: 200,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
