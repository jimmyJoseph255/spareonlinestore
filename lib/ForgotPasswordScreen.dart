import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:myproject/Screens/Dashboard/DashboardScreen.dart';
import 'package:myproject/controller.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false; // Variable to track the loading state
  final OTPController _otpControllerInstance =
      Get.put(OTPController(mobile: ''));

  @override
  void initState() {
    super.initState();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator when request starts
      });

      // Get the phone number, OTP, and new password
      String phone = _phoneController.text;
      String otp = _otpController.text;
      String newPassword = _newPasswordController.text;

      // Prepare the request body
      Map<String, String> body = {
        'phone': phone,
        'otp': otp,
        'new_password': newPassword,
      };

      try {
        // Make the POST request to reset the password
        final response = await http.post(
          Uri.parse(
              'https://sparefasta.co.tz/api/password-reset/verify-otp-phone'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(body),
        );

        setState(() {
          _isLoading =
              false; // Hide the loading indicator once the request completes
        });

        if (response.statusCode == 200) {
          // Password reset successful
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password Reset Successful'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Navigate to DashboardScreen
          //Get.offAll(() => const DashboardScreen());
        } else {
          // Handle error from the server
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to reset password. Please try again.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        // Handle network or other errors
        setState(() {
          _isLoading = false; // Hide loading on error as well
        });
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
          'Forgot Password',
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
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Phone Number Field
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
                    const SizedBox(height: 20),

                    // OTP Field
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'OTP',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon:
                            const Icon(Icons.lock, color: Colors.black54),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the OTP';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // New Password Field
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon:
                            const Icon(Icons.lock, color: Colors.black54),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 70),

                    // Reset Password Button with loading indicator
                    ElevatedButton(
                      onPressed: _isLoading ? null : _resetPassword,
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
                              'Reset Password',
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                    ),
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
