import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatelessWidget {
  final String amount;
  const PaymentDetailsScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Details")),
      body: Center(child: Text("Payment Amount: $amount")),
    );
  }
}

class SecurityAlertScreen extends StatelessWidget {
  final String device;
  const SecurityAlertScreen({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Security Alert")),
      body: Center(child: Text("Accessed from: $device")),
    );
  }
}

class OfferDetailsScreen extends StatelessWidget {
  final String discountCode;
  const OfferDetailsScreen({super.key, required this.discountCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exclusive Offer")),
      body: Center(child: Text("Use code: $discountCode to save!")),
    );
  }
}
