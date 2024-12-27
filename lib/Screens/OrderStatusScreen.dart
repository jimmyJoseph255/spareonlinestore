import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/FeedBackScreen.dart';

class OrderStatusScreen extends StatefulWidget {
  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
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
      appBar: AppBar(
        title: Text(
          'Order Status',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
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
              Container(
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
            color: isCompleted ? Colors.green : Colors.grey,
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
      ),
      child:
          isCompleted ? Icon(Icons.check, color: Colors.white, size: 24) : null,
    );
  }
}
