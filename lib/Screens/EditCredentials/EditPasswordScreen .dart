import 'package:flutter/material.dart';

class EditPasswordScreen extends StatelessWidget {
  const EditPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
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
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
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
              controller: oldPasswordController,
              decoration: customInputDecoration('Old Password', Icons.lock),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: newPasswordController,
              decoration:
                  customInputDecoration('New Password', Icons.lock_outline),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: confirmPasswordController,
              decoration:
                  customInputDecoration('Confirm New Password', Icons.check),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (newPasswordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('New password and confirmation do not match'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Add logic to update the password here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password updated successfully!'),
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
                  'Update Password',
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
