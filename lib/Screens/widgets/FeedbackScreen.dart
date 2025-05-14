import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int rating = 0; // Variable to track the selected rating
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        title: Text(
          'Feedback',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF43A4F3), Color(0xFF1E88E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title for comments section
              Text(
                'Leave a comment:',
                style: GoogleFonts.lato(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),

              // TextField for comment input
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write your comment here...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  contentPadding: EdgeInsets.all(12),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),

              // Title for rating section
              Text(
                'Rate your service:',
                style: GoogleFonts.lato(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),

              // Star Rating (5 stars)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        rating =
                            index + 1; // Set rating based on the clicked star
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(8),
                      transform: Matrix4.identity()
                        ..scale(index < rating ? 1.2 : 1.0),
                      child: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        size: 40,
                        color:
                            index < rating ? Colors.orangeAccent : Colors.white,
                      ), // Add scaling effect
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),

              // Submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the submit logic here
                    String comment = _commentController.text;
                    // Use a logging framework instead of print
                    debugPrint('Comment: $comment');
                    debugPrint('Rating: $rating');

                    // Show snackbar after submitting feedback
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Feedback Submitted'),
                        backgroundColor: Colors.black,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Submit Feedback',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
