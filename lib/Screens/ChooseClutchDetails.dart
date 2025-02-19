import 'package:flutter/material.dart';
import 'package:myproject/Screens/ClutchDetailsScreen.dart'; // Assuming this is the correct screen for clutch details

class ChooseClutchDetails extends StatefulWidget {
  const ChooseClutchDetails({super.key});

  @override
  _ChooseClutchDetailsState createState() => _ChooseClutchDetailsState();
}

class _ChooseClutchDetailsState extends State<ChooseClutchDetails> {
  String? _selectedClutch; // Variable to store the selected clutch option

  // List of available clutch options
  final List<String> clutchOptions = [
    'Single Plate Clutch',
    'Multi Plate Clutch',
    'Cone Clutch',
    'Diaphragm Clutch',
    'Centrifugal Clutch',
    'Semi-Automatic Clutch',
    'Hydraulic Clutch',
    'Vacuum Clutch',
  ];

  // Navigate to the next screen based on selected clutch
  void _navigateToClutchScreen(String clutch) {
    if (clutch.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ClutchDetailsScreen(), // Modify this if you have a different screen for clutches
        ),
      );
    } else {
      // Show a snack bar to guide the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Choose Your clutch',
            style: TextStyle(color: Colors.black),
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
        title: const Text(
          'Choose Your Clutch',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        leading: GestureDetector(
          onTap: () {
            // Silent back navigation when the back button is tapped
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 67, 164, 243),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: clutchOptions.length,
                itemBuilder: (context, index) {
                  final clutch = clutchOptions[index];
                  return RadioListTile<String>(
                    title: Text(
                      clutch,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: clutch,
                    groupValue: _selectedClutch,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedClutch = value;
                      });
                    },
                  );
                },
              ),
            ),
            // Increased vertical margin between the list and the button
            GestureDetector(
              onTap: () {
                _navigateToClutchScreen(_selectedClutch ?? '');
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
