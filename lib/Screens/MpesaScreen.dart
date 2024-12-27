import 'package:flutter/material.dart';

class MpesaScreen extends StatelessWidget {
  const MpesaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('M-Pesa'),
        backgroundColor: Colors.white, // Set AppBar background color to white
        iconTheme: IconThemeData(
            color: Colors.black), // Set icon color to black for visibility
      ),
      backgroundColor:
          Colors.white, // Set the background color of the body to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lipa Namba',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 20),
            Text(
              '445445',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 30), // Add space between text and button
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                        vertical: 16, horizontal: 100)), // Increase button size
                backgroundColor: MaterialStateProperty.all<Color>(Color(
                    0xFFD2393D)), // Set the background color of the button
              ),
              child: Text(
                "DIAL *150*00*",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white), // Adjust text size if needed
              ),
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black), // Default style for the text
                children: <TextSpan>[
                  TextSpan(text: "1. Dial "),
                  TextSpan(
                    text: "*150*00*",
                    style: TextStyle(
                        fontWeight: FontWeight.bold), // Make this part bold
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black), // Default style for the text
                children: <TextSpan>[
                  TextSpan(text: "2. Select "),
                  TextSpan(
                    text: "4-Pay Bills",
                    style: TextStyle(
                        fontWeight: FontWeight.bold), // Make this part bold
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black), // Default style for the text
                children: <TextSpan>[
                  TextSpan(text: "3. Select "),
                  TextSpan(
                    text: "3-Enter Business Number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold), // Make this part bold
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black), // Default style for the text
                children: <TextSpan>[
                  TextSpan(text: "4. Enter Reference Number"),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black), // Default style for the text
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "5. Enter Your deposit amount and PIN to Confirm payment"),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black), // Default style for the text
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "6. You will receive notification confirming transaction"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
