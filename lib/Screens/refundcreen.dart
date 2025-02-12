import 'package:flutter/material.dart';

class RefundScreen extends StatefulWidget {
  const RefundScreen({super.key});

  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _orderIdController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  String? _selectedReason;
  final List<String> _refundReasons = [
    'Product Damaged',
    'Wrong Item',
    'Not Satisfied',
    'Other'
  ];

  void _submitRefundRequest() {
    if (_formKey.currentState!.validate()) {
      // Handle the refund request submission here.
      // For example, make a network request to submit the refund.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Refund request submitted!')),
      );
      // Clear the form
      _orderIdController.clear();
      _reasonController.clear();
      setState(() {
        _selectedReason = null;
      });
      // Navigate back to the DashboardScreen after a successful refund submission
      Future.delayed(const Duration(seconds: 1), () {
        // This delay is to allow the user to see the success message
        Navigator.pop(
            context); // This will take the user back to the previous screen, which we assume is the dashboard
        // Alternatively, if you want to push to a specific screen, use:
        // Navigator.pushReplacementNamed(context, '/dashboard'); // You can use this if you are using named routes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Refund Request',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID Field
                TextFormField(
                  controller: _orderIdController,
                  decoration: const InputDecoration(
                    labelText: 'Order ID',
                    hintText: 'Enter your order ID',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your order ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Refund Reason Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedReason,
                  decoration: const InputDecoration(
                    labelText: 'Reason for Refund',
                    border: OutlineInputBorder(),
                  ),
                  items: _refundReasons.map((reason) {
                    return DropdownMenuItem<String>(
                      value: reason,
                      child: Text(reason),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedReason = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a reason';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Additional Notes Text Field
                TextFormField(
                  controller: _reasonController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Additional Notes (Optional)',
                    hintText: 'Any extra details about the refund',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitRefundRequest,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Submit Refund Request',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
