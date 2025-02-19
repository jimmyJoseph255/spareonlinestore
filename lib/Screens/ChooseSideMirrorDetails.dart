import 'package:flutter/material.dart';
import 'package:myproject/Screens/SideMirrorDetailsScreen.dart'; // Assuming this is the correct screen for side mirrors

class ChooseSideMirrorDetails extends StatefulWidget {
  const ChooseSideMirrorDetails({super.key});

  @override
  _ChooseSideMirrorDetailsState createState() =>
      _ChooseSideMirrorDetailsState();
}

class _ChooseSideMirrorDetailsState extends State<ChooseSideMirrorDetails> {
  String?
      _selectedSideMirror; // Variable to store the selected side mirror option

  // List of available side mirror options
  final List<String> sideMirrorOptions = [
    'Manual Side Mirror',
    'Power Side Mirror',
    'Heated Side Mirror',
    'Auto-Dimming Side Mirror',
  ];

  // Navigate to the next screen based on selected side mirror
  void _navigateToSideMirrorScreen(String sideMirror) {
    if (sideMirror.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SideMirrorDetailsScreen(), // Modify this if you have a different screen for side mirrors
        ),
      );
    } else {
      // Show a snack bar to guide the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Choose Your side mirror',
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
          'Choose Your Side Mirror',
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: sideMirrorOptions.length,
              itemBuilder: (context, index) {
                final sideMirror = sideMirrorOptions[index];
                return RadioListTile<String>(
                  title: Text(
                    sideMirror,
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: sideMirror,
                  groupValue: _selectedSideMirror,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedSideMirror = value;
                    });
                  },
                );
              },
            ),
            // Increased vertical margin between the list and the button
            GestureDetector(
              onTap: () {
                _navigateToSideMirrorScreen(_selectedSideMirror ?? '');
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
