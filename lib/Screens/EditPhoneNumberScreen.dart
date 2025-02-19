import 'package:flutter/material.dart';

class EditPhoneNumberScreen extends StatelessWidget {
  const EditPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController oldPhoneNumberController =
        TextEditingController();
    final TextEditingController newPhoneNumberController =
        TextEditingController();
    final TextEditingController confirmPhoneNumberController =
        TextEditingController();

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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: const Text('Change Phone Number'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: oldPhoneNumberController,
              decoration:
                  customInputDecoration('Old Phone Number', Icons.phone),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: newPhoneNumberController,
              decoration: customInputDecoration(
                  'New Phone Number', Icons.phone_android),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: confirmPhoneNumberController,
              decoration: customInputDecoration(
                  'Confirm New Phone Number', Icons.check),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (newPhoneNumberController.text !=
                      confirmPhoneNumberController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'New Phone Number and confirmation do not match'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Add logic to update the phone number here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Phone Number updated successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 252, 247, 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                child: const Text(
                  'Update Phone Number',
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
    );
  }
}
