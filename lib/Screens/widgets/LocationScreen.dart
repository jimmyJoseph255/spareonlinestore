import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'DateSelectionScreen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController _mapController;
  final TextEditingController locationController = TextEditingController();

  LatLng currentLatLng =
      const LatLng(-6.776012, 39.178326); // Default Dar es Salaam

  final String googleApiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // Replace this!

  // Function to get coordinates from place name using Google Geocoding API
  Future<void> _searchLocation() async {
    String placeName = locationController.text.trim();
    if (placeName.isEmpty) return;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=$placeName&key=$googleApiKey',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        setState(() {
          currentLatLng = LatLng(location['lat'], location['lng']);
        });

        _mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLatLng, zoom: 15),
          ),
        );
      } else {
        _showMessage('Location not found. Try another name.');
      }
    } catch (e) {
      _showMessage('Failed to fetch location. Check your connection.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customer Location",
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: currentLatLng, zoom: 12),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: {
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: currentLatLng,
                  infoWindow: const InfoWindow(title: 'Selected Location'),
                )
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: "Enter Place Name",
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.location_on, color: Colors.green),
                    onPressed: _searchLocation,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DateSelectionScreen()),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
