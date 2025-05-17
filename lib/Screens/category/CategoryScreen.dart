import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import CarouselSlider
import 'package:google_fonts/google_fonts.dart';

import 'package:myproject/Screens/ChooseProduct/ChooseBrakeSystemDetails.dart';
import 'package:myproject/Screens/ChooseProduct/ChooseCarBatteryDetails.dart';
import 'package:myproject/Screens/ChooseProduct/ChooseClutchDetails.dart';
import 'package:myproject/Screens/ChooseProduct/ChooseEngineDetails.dart';
import 'package:myproject/Screens/ChooseProduct/ChooseSideMirrorDetails.dart';
import 'package:myproject/Screens/ChooseProduct/ChooseSpeakerDetails.dart';
import 'package:myproject/Screens/ChooseProduct/choosetyredetails.dart';
import 'package:myproject/Screens/products/SideMirrorDetailsScreen.dart';
import 'package:myproject/Screens/products/SuspensionsDetailsScreen.dart';
import 'package:myproject/Screens/products/exhaustdetails.dart';

import '../products/BrakeDetailsScreen.dart';

class CategoryScreen extends StatelessWidget {
  // List of category names, icons, and background colors
  final categoryData = [
    {
      'name': 'Car-Tyre',
      'icon': 'lib/images/product_tyre.png',
      'color': Colors.red
    },
    {
      'name': 'Speakers',
      'icon': 'lib/images/speaker-filled-audio-tool.png',
      'color': Colors.green
    },
    {
      'name': 'Brake System',
      'icon': 'lib/images/brakeicon.png',
      'color': Colors.orange
    },
    {
      'name': 'Side Mirror',
      'icon': 'lib/images/side-mirror.png',
      'color': const Color.fromARGB(255, 10, 6, 238)
    },
    {
      'name': 'Engine',
      'icon': 'lib/images/car-engine.png',
      'color': Colors.purple
    },
    {'name': 'Clutch', 'icon': 'lib/images/clutch.png', 'color': Colors.yellow},
    {
      'name': 'Battery',
      'icon': 'lib/images/car-battery.png',
      'color': Colors.brown
    },
    {'name': 'Suspension', 'icon': Icons.directions_car, 'color': Colors.teal},
    {
      'name': 'Exhaust',
      'icon': Icons.filter_tilt_shift,
      'color': Colors.deepOrange
    },
  ];

  CategoryScreen({super.key});

  // Function to build the carousel slider
  Widget _buildCarouselSlider(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
      ),
      items: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BrakeDetailsScreen()),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 175, 16, 77),
                  Color.fromARGB(255, 34, 34, 34),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.3, 0.9],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Boda stress!",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "High-Quality",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Brakes",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              minimumSize: Size(0, 20),
                            ),
                            icon: Icon(Icons.shopping_cart,
                                size: 12, color: Colors.black),
                            label: Text(
                              'Order Now',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'lib/images/Brake.png',
                      height: 150,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Category',
          style: GoogleFonts.lato(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Silent back navigation when the back button is tapped
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCarouselSlider(context), // Use the carousel slider
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 24.0,
                    mainAxisSpacing: 24.0,
                  ),
                  itemCount: categoryData.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final category = categoryData[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (category['name'] == 'Car-Tyre') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseTyreDetails(),
                                ),
                              );
                            } else if (category['name'] == 'Speakers') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseSpeakerDetails(),
                                ),
                              );
                            } else if (category['name'] == 'Side Mirror') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SideMirrorDetailsScreen(),
                                ),
                              );
                            } else if (category['name'] == 'Brake System') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BrakeDetailsScreen(),
                                ),
                              );
                            } else if (category['name'] == 'Engine') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseEngineDetails(),
                                ),
                              );
                            } else if (category['name'] == 'Clutch') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseClutchDetails(),
                                ),
                              );
                            } else if (category['name'] == 'Battery') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChooseCarBatteryDetails(),
                                ),
                              );
                            } else if (category['name'] == 'Exhaust') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExhaustDetailsScreen(),
                                ),
                              );
                            } else if (category['name'] == 'Suspension') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SuspensionDetailsScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('${category['name']} Pressed')),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: category['color'] as Color?,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            width: 90,
                            height: 80,
                            child: Center(
                              child: category['icon'] is String
                                  ? Image.asset(
                                      category['icon'] as String,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      category['icon'] as IconData,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          category['name'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
