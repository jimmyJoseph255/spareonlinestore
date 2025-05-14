import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/cart/cart_screen.dart';
import 'package:myproject/Screens/widgets/shared_data.dart';

class EngineDetailsInside extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  const EngineDetailsInside({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  State<EngineDetailsInside> createState() => _EngineDetailsInsideState();
}

class _EngineDetailsInsideState extends State<EngineDetailsInside> {
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
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Engine Details',
          style: GoogleFonts.lato(
            fontSize: 18,
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.productName,
            style: GoogleFonts.lato(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 10),
          Image.network(widget.productImage, height: 200, width: 200),
          const SizedBox(height: 20),
          Text(
            widget.productPrice,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 249, 253, 0),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  // Add product to cart
                  cartItems.add({
                    'name': widget.productName,
                    'price': widget.productPrice,
                    'image': widget.productImage,
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
                  ); // Silent back navigation
                },
                child: Text(
                  'Add to Cart',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
