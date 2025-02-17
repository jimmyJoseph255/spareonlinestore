import 'package:flutter/material.dart';
import 'package:myproject/Screens/CarBatteryDetailsScree.dart';

class ChooseCarBatteryDetails extends StatefulWidget {
  const ChooseCarBatteryDetails({super.key});

  @override
  _ChooseCarBatteryDetailsState createState() =>
      _ChooseCarBatteryDetailsState();
}

class _ChooseCarBatteryDetailsState extends State<ChooseCarBatteryDetails> {
  String? _selectedBattery; // Variable to store the selected battery option

  // List of available car battery options
  final List<String> batteryOptions = [
    'Exide 12V Battery',
    'Amaron 12V Battery',
    'Luminous 12V Battery',
    'SF Sonic 12V Battery',
    'Varta 12V Battery',
    'Bosch 12V Battery',
    'Optima YellowTop Battery',
    'ACDelco 12V Battery',
    'EverStart 12V Battery',
  ];

  // Navigate to the next screen based on selected battery
  void _navigateToBatteryScreen(String battery) {
    if (battery.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CarBatteryDetailsScreen(), // Modify this if you have a different screen for car batteries
        ),
      );
    } else {
      // Show a snack bar to guide the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Choose Your car battery',
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
          'Choose Your Car Battery',
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
                itemCount: batteryOptions.length,
                itemBuilder: (context, index) {
                  final battery = batteryOptions[index];
                  return RadioListTile<String>(
                    title: Text(
                      battery,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: battery,
                    groupValue: _selectedBattery,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedBattery = value;
                      });
                    },
                  );
                },
              ),
            ),
            // Increased vertical margin between the list and the button
            GestureDetector(
              onTap: () {
                _navigateToBatteryScreen(_selectedBattery ?? '');
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
