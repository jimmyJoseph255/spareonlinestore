import 'package:flutter/material.dart';
import 'package:myproject/Screens/EngineDetailsScreen.dart'; // Assuming this is the correct screen for engine details

class ChooseEngineDetails extends StatefulWidget {
  const ChooseEngineDetails({super.key});

  @override
  _ChooseEngineDetailsState createState() => _ChooseEngineDetailsState();
}

class _ChooseEngineDetailsState extends State<ChooseEngineDetails> {
  String? _selectedEngine; // Variable to store the selected engine option

  // List of available engine options
  final List<String> engineOptions = [
    'V6 Engine',
    'V8 Engine',
    'Electric Engine',
    'Inline-4 Engine',
    'Inline-6 Engine',
    'V10 Engine',
    'V12 Engine',
    'Rotary Engine',
    'Flat-4 Engine',
    'Diesel Engine',
    'Turbocharged Engine',
    'Supercharged Engine',
    '1.3L 4-cylinder Engine (1NZ-FE) - Toyota IST',
    '1.5L 4-cylinder Engine (1NZ-FE) - Toyota IST',
  ];

  // Navigate to the next screen based on selected engine
  void _navigateToEngineScreen(String engine) {
    if (engine.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EngineDetailsScreen(), // Modify this if you have a different screen for engines
        ),
      );
    } else {
      // Show a snack bar to guide the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Choose Your engine',
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
          'Choose Your Engine',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
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
                itemCount: engineOptions.length,
                itemBuilder: (context, index) {
                  final engine = engineOptions[index];
                  return RadioListTile<String>(
                    title: Text(
                      engine,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: engine,
                    groupValue: _selectedEngine,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedEngine = value;
                      });
                    },
                  );
                },
              ),
            ),
            // Increased vertical margin between the list and the button
            GestureDetector(
              onTap: () {
                _navigateToEngineScreen(_selectedEngine ?? '');
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
