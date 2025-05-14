import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/EditCredentials/EditPasswordScreen%20.dart';

class AccountSecurityScreen extends StatelessWidget {
  const AccountSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        title: Text(
          'Account Security',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add security and settings options here
            _buildCardItem(
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditPasswordScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildCardItem(
              icon: Icons.security,
              title: 'Two-Factor Authentication',
              onTap: () {
                // Handle Two-Factor Authentication functionality here
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create each card with ListItem inside it
  Widget _buildCardItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color.fromARGB(255, 255, 251, 0),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
