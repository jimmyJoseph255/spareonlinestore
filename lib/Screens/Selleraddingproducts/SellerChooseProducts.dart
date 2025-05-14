import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/Selleraddingproducts/AddingCarTyresScreen%20.dart';
import 'package:myproject/Screens/Selleraddingproducts/CarBaterries.dart';

import 'package:myproject/Screens/Selleraddingproducts/ClutchScreen.dart'; // Import the ClutchScreen
import 'package:myproject/Screens/Selleraddingproducts/BrakeSystemScreen.dart'; // Import the BrakeSystemScreen
import 'package:myproject/Screens/Selleraddingproducts/AddingEngineScreen.dart'; // Import the EngineScreen
import 'package:myproject/Screens/Selleraddingproducts/AddingSideMirrorScreen.dart';
import 'package:myproject/Screens/Selleraddingproducts/Suspensions.dart'; // Import the SideMirrorScreen

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: Text(
          "Choose category",
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // First Row of Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarTyresScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Car tyre button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // Rectangular with rounded corners
                        ),
                      ),
                      child: SizedBox(
                        width: 60, // Increased width
                        height: 90, // Increased height
                        child: Image.asset(
                          'lib/images/product_tyre.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Car tyre",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClutchScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Clutch button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 90,
                        child: Image.asset(
                          'lib/images/clutch.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Clutch",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrakeSystemScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Brake system button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 90,
                        child: Image.asset(
                          'lib/images/brakeicon.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Brake System",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16), // Spacing between rows

            // Second Row of Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EngineScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Engine button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 90,
                        child: Image.asset(
                          'lib/images/car-engine.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Engine",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SideMirrorScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.purple, // Side Mirror button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 90,
                        child: Image.asset(
                          'lib/images/side-mirror.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Side Mirror",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarBatteriesScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow, // Battery button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 90,
                        child: Image.asset(
                          'lib/images/car-battery.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Battery",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16), // Spacing between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EngineScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Engine button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 90,
                        child: Image.asset(
                          'lib/images/car-engine.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Engine",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SideMirrorScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.purple, // Side Mirror button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 90,
                        child: Image.asset(
                          'lib/images/side-mirror.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Side Mirror",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuspensionsScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow, // Battery button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 90,
                        child: Image.asset(
                          'lib/images/suspension.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Suspensions",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
