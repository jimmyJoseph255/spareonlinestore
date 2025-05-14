import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/products/BrakeDetailsScreen.dart';
// Assuming this is the correct screen for brake systems

class ChooseBrakeSystemDetails extends StatefulWidget {
  const ChooseBrakeSystemDetails({super.key});

  @override
  _ChooseBrakeSystemDetailsState createState() =>
      _ChooseBrakeSystemDetailsState();
}

class _ChooseBrakeSystemDetailsState extends State<ChooseBrakeSystemDetails> {
  String?
      _selectedBrakeSystem; // Variable to store the selected brake system option

  // List of available brake system options
  final List<String> brakeSystemOptions = [
    'Disc Brake',
    'Drum Brake',
    'Anti-lock Braking System (ABS)',
    'Electronic Parking Brake (EPB)',
  ];

  // Navigate to the next screen based on selected brake system
  void _navigateToBrakeSystemScreen(String brakeSystem) {
    if (brakeSystem.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BrakeDetailsScreen(), // Modify this if you have a different screen for brake systems
        ),
      );
    } else {
      // Show a snack bar to guide the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Choose Yours',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: Text(
          'Choose Yours',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        leading: GestureDetector(
          onTap: () {
            // Silent back navigation when the back button is tapped
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 67, 164, 243),
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: brakeSystemOptions.length,
              itemBuilder: (context, index) {
                final brakeSystem = brakeSystemOptions[index];
                return RadioListTile<String>(
                  title: Text(
                    brakeSystem,
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: brakeSystem,
                  groupValue: _selectedBrakeSystem,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedBrakeSystem = value;
                    });
                  },
                );
              },
            ),
            // Increased vertical margin between the list and the button
            GestureDetector(
              onTap: () {
                _navigateToBrakeSystemScreen(_selectedBrakeSystem ?? '');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 50), // Increased vertical margin
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
