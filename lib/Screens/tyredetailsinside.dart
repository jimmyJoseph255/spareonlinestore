import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'shared_data.dart';

class TyreDetailsInside extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  const TyreDetailsInside({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  State<TyreDetailsInside> createState() => _TyreDetailsInsideState();
}

class _TyreDetailsInsideState extends State<TyreDetailsInside> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Tyre Details',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            // Silent back navigation when the back button is tapped
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.productName,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Image.network(widget.productImage, height: 200, width: 200),
          const SizedBox(height: 20),
          Text(widget.productPrice,
              style: const TextStyle(fontSize: 20, color: Colors.blue)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Add product to cart
                  cartItems.add({
                    'name': widget.productName,
                    'price': widget.productPrice,
                    'image': widget.productImage,
                  });

                  // Show snack bar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item added to cart!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Automatically navigate to CartScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
