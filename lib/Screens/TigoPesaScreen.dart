import 'package:flutter/material.dart';
import 'package:myproject/Screens/OrderStatusScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TigoPesaScreen(),
  ));
}

class TigoPesaScreen extends StatelessWidget {
  const TigoPesaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tigo Pesa'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
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
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '445445',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 100)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: Text(
                "DIAL *150*01*",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            ..._buildInstructions(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to ReceiptScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderStatusScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "Submit Receipt",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInstructions() {
    return [
      RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: "1. Dial "),
            TextSpan(
              text: "*150*01*",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
      RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: "2. Select "),
            TextSpan(
              text: "4-Pay Bills",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
      RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: "3. Select "),
            TextSpan(
              text: "3-Enter Business Number",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
      RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: "4. Enter Reference Number"),
          ],
        ),
      ),
      SizedBox(height: 10),
      RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
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
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text:
                    "6. You will receive notification confirming transaction"),
          ],
        ),
      ),
    ];
  }
}
