import 'package:flutter/material.dart';

class SellerReportScreen extends StatelessWidget {
  const SellerReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Report'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Reports will be displayed here'),
      ),
    );
  }
}
