import 'package:flutter/material.dart';
import 'package:myproject/Screens/tyredetails.dart';

class ChooseTyreDetails extends StatefulWidget {
  const ChooseTyreDetails({super.key});

  @override
  _ChooseTyreDetailsState createState() => _ChooseTyreDetailsState();
}

class _ChooseTyreDetailsState extends State<ChooseTyreDetails> {
  String? _selectedSize; // Variable to store the selected size

  // List of available tire sizes
  final List<String> tireSizes = [
    '13 inches',
    '14 inches',
    '15 inches',
    '16 inches',
    '17 inches',
    '18 inches',
    '19 inches',
    '20 inches',
  ];

  // Navigate to the specific tire screen based on selected size
  void _navigateToTireScreen(String size) {
    if (size.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TyreDetailsScreen(),
        ),
      );
    } else {
      // Show a snack bar to guide the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a tire size',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 67, 164, 243), // Background color of the scaffold
      appBar: AppBar(
        title: const Text(
          'Choose Your Size',
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
        color: const Color.fromARGB(255, 67, 164,
            243), // Applying the same background color to the body
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Remove the Expanded widget so the button comes right after the ListView
            ListView.builder(
              shrinkWrap:
                  true, // Ensures the ListView only takes necessary space
              itemCount: tireSizes.length,
              itemBuilder: (context, index) {
                final size = tireSizes[index];
                return RadioListTile<String>(
                  title: Text(
                    size,
                    style: const TextStyle(
                        color: Colors.white), // White text for the list items
                  ),
                  value: size,
                  groupValue: _selectedSize,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedSize = value;
                    });
                  },
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            // Button positioned right after the list
            GestureDetector(
              onTap: () {
                _navigateToTireScreen(_selectedSize ?? '');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
