import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String title;
  final String message;
  final String timeAgo;

  const NotificationDetailScreen({
    super.key,
    required this.title,
    required this.message,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.lato(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(timeAgo,
                style: GoogleFonts.lato(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            Text(message, style: GoogleFonts.lato(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
