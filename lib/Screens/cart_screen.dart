import 'package:flutter/material.dart';
import 'locationscreen.dart'; // Import the location screen
import 'shared_data.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              Text(
                                item['name']!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item['price']!,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.blue),
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
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        color: Colors.green),
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
                          const Text('Subtotal:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('\$${subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Taxes & Fees:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('\$${taxes.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Delivery Fee:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('\$${deliveryFee.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Cost:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('\$${totalCost.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16)),
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
                            builder: (context) => const LocationScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 150),
                    ),
                    child: const Text('Next',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
    );
  }
}
