import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myproject/Screens/OrderDetailScreen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Function to launch the phone dialer
  void _callRider() async {
    const phoneNumber = "tel:+255710661252"; // Rider's phone number
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      throw "Could not launch $phoneNumber";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Silent back navigation
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ongoing Orders",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            _buildOngoingOrder(),
            const SizedBox(height: 20),
            const Text(
              "Past Orders",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildPastOrders()),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingOrder() {
    return GestureDetector(
      onTap: () {
        // Optional: Add navigation or additional functionality if desired
      },
      child: Card(
        color: const Color.fromARGB(255, 255, 251, 0),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Order #12345",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              const Text("Status: On The Way",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Estimated Delivery: 15 mins"),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Implement tracking logic
                    },
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on, color: Colors.white),
                      label: const Text(
                        "Track Order",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 182, 27, 27)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _callRider, // Call function to dial the number
                    child: ElevatedButton.icon(
                      onPressed: _callRider,
                      icon: const Icon(Icons.phone, color: Colors.white),
                      label: const Text(
                        "Call Rider",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPastOrders() {
    List<Map<String, String>> pastOrders = [
      {
        "id": "12344",
        "date": "Feb 10, 2025",
        "items": "Side Mirror, SUV",
        "total": "\$20"
      },
      {
        "id": "12343",
        "date": "Feb 5, 2025",
        "items": "Tyre, 21 inches",
        "total": "\$15"
      },
    ];

    return ListView.builder(
      itemCount: pastOrders.length,
      itemBuilder: (context, index) {
        var order = pastOrders[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailScreen(
                  orderId: order['id']!,
                  date: order['date']!,
                  items: order['items']!,
                  total: order['total']!,
                ),
              ),
            );
          },
          child: Card(
            color: const Color.fromARGB(255, 255, 251, 0),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text("Order #${order['id']}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${order['items']} - ${order['date']}"),
              trailing: Text(order['total']!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ),
        );
      },
    );
  }
}
