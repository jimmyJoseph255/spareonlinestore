import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding

class EditUsernameScreen extends StatefulWidget {
  const EditUsernameScreen({super.key});

  @override
  _EditUsernameScreenState createState() => _EditUsernameScreenState();
}

class _EditUsernameScreenState extends State<EditUsernameScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false; // Track loading state

  // Function to update profile
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start loading
      });

      final url =
          Uri.parse('https://sparefasta.co.tz/api/customer/update-profile');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({
        'name': _nameController.text,
      });

      try {
        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200) {
          // Success SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          // Error SnackBar
          final responseBody = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(responseBody['message'] ?? 'Failed to update profile'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        // Server error SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
    }
  }

  InputDecoration customInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87, fontSize: 16),
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: const Text('Username'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Phone Number Field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.text,
                decoration: customInputDecoration('Old Username', Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // New Username Field
              TextFormField(
                controller: _nameController,
                decoration: customInputDecoration('New Username', Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Confirm New Username Field
              TextFormField(
                controller: _confirmNameController,
                decoration:
                    customInputDecoration('Confirm New Username', Icons.check),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new username';
                  }
                  if (value != _nameController.text) {
                    return 'Username does not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),
              // Update Profile Button
              Center(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 247, 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 255, 0, 0))
                      : const Text(
                          'Update Username',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
