import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/ForgotPasswordScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PhoneNumberEntryScreen extends StatefulWidget {
  @override
  _PhoneNumberEntryScreenState createState() => _PhoneNumberEntryScreenState();
}

class _PhoneNumberEntryScreenState extends State<PhoneNumberEntryScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Function to generate a 6-digit OTP
  // String _generateOTP() {
  //   final Random random = Random();
  //   return (100000 + random.nextInt(900000)).toString();
  // }

  // Function to send OTP to the server
  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Get the phone number and generate OTP
      String phoneNumber = _phoneController.text;
      // String otp = _generateOTP();

      try {
        // Send the OTP to the server
        final response = await http.post(
          Uri.parse(
              'https://sparefasta.co.tz/api/password-reset/send-otp-phone'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'phone': phoneNumber,
          }),
        );

        if (response.statusCode == 200) {
          // OTP sent successfully, navigate to the next screen
          setState(() {
            _isLoading = false;
          });
          Get.to(() => ForgotPasswordScreen());
        } else {
          // Handle error if the response is not successful
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send OTP. Please try again.')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        // Handle network or other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          'Enter Phone Number',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon:
                            const Icon(Icons.phone, color: Colors.black54),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 80),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _sendOTP,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        minimumSize: const Size(80, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.yellow,
                        shadowColor: Colors.black.withOpacity(0.3),
                        elevation: 8,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Send OTP',
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
