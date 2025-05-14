import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/Dashboard/SellerDashboardScreen.dart';

class SellerOrdersScreen extends StatefulWidget {
  @override
  _SellerOrdersScreenState createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SellerDashboardScreen()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Orders',
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 67, 164, 243),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(30),
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.amber, width: 2),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              enableFeedback: false, // Disable sound feedback
              tabs: [
                Tab(
                  child: Text(
                    'Pending',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'On the Way',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SellerDashboardScreen()),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(), // Disable scrolling
          children: [
            OrderList(status: 'Pending'),
            OrderList(status: 'On the Way'),
            OrderList(status: 'Completed'),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String status;

  OrderList({required this.status});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'On the Way':
        return Colors.purple;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 67, 164, 243),
            Colors.grey.shade200
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: const Color.fromARGB(255, 245, 220, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(
                'Order #${index + 1}',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Customer: John Doe',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Product: Side Mirror - Toyota Corolla',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Price: \$150',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Delivery Address: Kunduchi Kinondoni',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Chip(
                    label: Text(status),
                    backgroundColor: _getStatusColor(status).withOpacity(0.2),
                    labelStyle: TextStyle(color: _getStatusColor(status)),
                  ),
                ],
              ),
              trailing: status == 'Pending'
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check_circle, color: Colors.green),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {},
                        ),
                      ],
                    )
                  : Icon(Icons.arrow_forward_ios,
                      color: const Color.fromARGB(255, 168, 17, 17)),
            ),
          );
        },
      ),
    );
  }
}
