import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/LoginAndSignUp/CustomerLoginScreen.dart';
import 'package:myproject/api_services/auth/auth_sslDisabled.dart'; // Ensure this is correct

class SellerRegistrationScreen extends StatefulWidget {
  @override
  _SellerRegistrationScreenState createState() =>
      _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false; // Track loading state

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final apiService = ApiService();

      try {
        final response = await apiService.post(
          '/customer/signup',
          {
            'name': _usernameController.text,
            'email': _emailController.text,
            'phone': _phoneController.text,
            'password': _passwordController.text,
          },
          headers: {},
        );

        print('Response: ${response.body}'); // Debugging

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Registration successful!',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
          );

          _usernameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();

          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _isLoading = false;
            });
            Get.offAllNamed('/login');
          });
        } else if (response.statusCode == 422) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Credentials have been already taken'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _isLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Could not reach the server. Check your internet connection!'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0072FF), Color(0xFF16AFDA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  "Create an Account",
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                          _usernameController, "Enter Full Name", Icons.person),
                      const SizedBox(height: 10),
                      _buildTextField(_emailController, "Email", Icons.email,
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 10),
                      _buildTextField(
                          _phoneController, "Phone Number", Icons.phone,
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 10),
                      _buildPasswordField(),
                      const SizedBox(height: 10),
                      _buildConfirmPasswordField(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _registerUser,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 60),
                          backgroundColor: Colors.yellow,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Color.fromARGB(255, 255, 255, 255))
                            : Text(
                                'Register',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerLoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Login Here',
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 300),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(icon, color: Colors.black54),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $hintText' : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: 'Enter Password',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: const Icon(Icons.lock, color: Colors.black54),
        suffixIcon: IconButton(
          icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black54),
          onPressed: () =>
              setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ),
      validator: (value) => value == null || value.length < 6
          ? 'Password must be at least 6 characters'
          : null,
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: !_isConfirmPasswordVisible,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: const Icon(Icons.lock, color: Colors.black54),
        suffixIcon: IconButton(
          icon: Icon(
              _isConfirmPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.black54),
          onPressed: () => setState(
              () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
        ),
      ),
      validator: (value) =>
          value != _passwordController.text ? 'Passwords do not match' : null,
    );
  }
}
