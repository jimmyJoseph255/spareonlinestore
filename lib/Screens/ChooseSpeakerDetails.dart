import 'package:flutter/material.dart';
import 'package:myproject/Screens/SpeakerDetailsScreen.dart';
import 'package:myproject/Screens/tyredetails.dart'; // Assuming this screen is relevant for speakers too

class ChooseSpeakerDetails extends StatefulWidget {
  const ChooseSpeakerDetails({super.key});

  @override
  _ChooseSpeakerDetailsState createState() => _ChooseSpeakerDetailsState();
}

class _ChooseSpeakerDetailsState extends State<ChooseSpeakerDetails> {
  String? _selectedSpeaker; // Variable to store the selected speaker option

  // List of available speaker options
  final List<String> speakerOptions = [
    'JBL Flip 5',
    'Sony SRS-XB43',
    'Bose SoundLink',
    'Ultimate Ears Boom 3',
  ];

  // Navigate to the next screen based on selected speaker
  void _navigateToSpeakerScreen(String speaker) {
    if (speaker.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SpeakerDetailsScreen(), // Modify this if you have a different screen for speakers
        ),
      );
    } else {
      // Show a snack bar to guide the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Choose Your speaker',
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
          'Choose Your Speaker',
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
              itemCount: speakerOptions.length,
              itemBuilder: (context, index) {
                final speaker = speakerOptions[index];
                return RadioListTile<String>(
                  title: Text(
                    speaker,
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: speaker,
                  groupValue: _selectedSpeaker,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedSpeaker = value;
                    });
                  },
                );
              },
            ),
            // Increased vertical margin between the list and the button
            GestureDetector(
              onTap: () {
                _navigateToSpeakerScreen(_selectedSpeaker ?? '');
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
