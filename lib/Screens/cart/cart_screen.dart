import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/LoginAndSignUp/CustomerLoginScreen.dart';
import 'package:myproject/Screens/widgets/DateSelectionScreen.dart';
import 'package:myproject/Screens/widgets/LocationScreen.dart';

import 'package:myproject/Screens/widgets/shared_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Function to calculate subtotal, taxes, delivery, and total costs
  double getSubtotal() {
    double subtotal = 0.0;
    for (var item in cartItems) {
      try {
        String priceString = item['price']!;
        priceString = priceString.replaceAll(RegExp(r'[^0-9.]'), '');
        double price = double.parse(priceString);
        int quantity = int.parse(item['quantity'] ?? '1');
        subtotal += price * quantity;
      } catch (e) {
        print('Error parsing price: ${item['price']}');
        subtotal += 0.0;
      }
    }
    return subtotal;
  }

  double getTaxes(double subtotal) {
    return subtotal * 0.10;
  }

  double getDeliveryFee() {
    return 5.00;
  }

  double getTotalCost(double subtotal, double taxes, double deliveryFee) {
    return subtotal + taxes + deliveryFee;
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = getSubtotal();
    double taxes = getTaxes(subtotal);
    double deliveryFee = getDeliveryFee();
    double totalCost = getTotalCost(subtotal, taxes, deliveryFee);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: Text(
          'Cart',
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
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                int quantity = int.parse(item['quantity'] ?? '1');

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          item['image']!,
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                item['price']!,
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity--;
                                          item['quantity'] =
                                              quantity.toString();
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    '$quantity',
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        color: Color.fromARGB(255, 0, 255, 8)),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                        item['quantity'] = quantity.toString();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null // Hide the bottom navigation when cart is empty
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal:',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          Text(
                            '\$${subtotal.toStringAsFixed(2)}',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Taxes & Fees:',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          Text(
                            '\$${taxes.toStringAsFixed(2)}',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Fee:',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          Text(
                            '\$${deliveryFee.toStringAsFixed(2)}',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Cost:',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          Text(
                            '\$${totalCost.toStringAsFixed(2)}',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 100),
                    ),
                    child: Text(
                      'Checkout',
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
