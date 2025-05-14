import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/orders/OrderDetailScreen.dart';
import 'package:myproject/Screens/orders/OrderStatusScreen.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text(
          "Orders",
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
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
            Text(
              "Ongoing Orders",
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 10),
            _buildOngoingOrder(),
            const SizedBox(height: 20),
            Text(
              "Past Orders",
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderStatusScreen()),
        );
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
              Text("Order #12345",
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  )),
              const SizedBox(height: 5),
              Text("Status: On The Way",
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  )),
              const SizedBox(height: 5),
              Text("Estimated Delivery: 15 mins",
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    //fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  )),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Implement tracking logic
                    },
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderStatusScreen()),
                        );
                      },
                      icon: const Icon(Icons.location_on, color: Colors.white),
                      label: Text(
                        "Track Order",
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
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
                      label: Text(
                        "Call Rider",
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
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
              title: Text(
                "Order #${order['id']}",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              subtitle: Text(
                "${order['items']} - ${order['date']}",
                style: GoogleFonts.lato(
                  fontSize: 15,
                  //fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              trailing: Text(
                order['total']!,
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
