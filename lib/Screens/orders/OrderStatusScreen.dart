import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/widgets/FeedbackScreen.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  int currentStep = -1; // Start with no step completed

  final List<String> steps = [
    "Order Picked Up",
    "On its Way",
    "Delivered",
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoProgress();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoProgress() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (currentStep < steps.length - 1) {
        setState(() {
          currentStep++;
        });
      } else {
        timer.cancel();
        // Navigate to FeedbackScreen when status reaches "Delivered"
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FeedbackScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF43A4F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF43A4F3),
        title: Text(
          'Order Status',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center content vertically
        children: [
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 300), // Limit Row width
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  steps.length,
                  (index) => _buildStep(index),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // Add any action you want to perform on button press
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              'Track Another Order',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int index) {
    bool isCompleted = index <= currentStep && currentStep != -1;
    bool isLast = index == steps.length - 1;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min, // Minimize Row width
          children: [
            // Step Circle
            _buildStepCircle(isCompleted),
            if (!isLast)
              // Animated Line
              SizedBox(
                width: 50, // Fixed width for the line
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: 4,
                  color:
                      index < currentStep ? Colors.green : Colors.grey.shade300,
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        // Step Label
        Text(
          steps[index],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isCompleted
                ? Colors.green
                : const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCircle(bool isCompleted) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? Colors.green : Colors.grey.shade300,
        boxShadow: [
          if (isCompleted)
            BoxShadow(
              color: Colors.green.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 10,
            ),
        ],
      ),
      child:
          isCompleted ? Icon(Icons.check, color: Colors.white, size: 24) : null,
    );
  }
}
