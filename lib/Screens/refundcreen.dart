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
        Navigator.pop(
            context); // This will take the user back to the previous screen, which we assume is the dashboard
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Silent back navigation when the back button is tapped
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        title: const Text(
          'Refund Request',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 67, 164, 243),
              Color.fromARGB(255, 67, 164, 243)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
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
                      decoration: InputDecoration(
                        labelText: 'Order ID',
                        hintText: 'Enter your order ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
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
                      decoration: InputDecoration(
                        labelText: 'Reason for Refund',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
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
                      decoration: InputDecoration(
                        labelText: 'Additional Notes (Optional)',
                        hintText: 'Any extra details about the refund',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
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
                          backgroundColor:
                              const Color.fromARGB(255, 255, 196, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          'Submit Refund Request',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
