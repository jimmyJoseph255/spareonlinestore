import 'package:flutter/material.dart';
import 'SellerDashboardScreen.dart'; // Import the SellerDashboardScreen

class SellerLoginPageScreen extends StatefulWidget {
  const SellerLoginPageScreen({super.key});

  @override
  State<SellerLoginPageScreen> createState() => _SellerLoginPageScreenState();
}

class _SellerLoginPageScreenState extends State<SellerLoginPageScreen> {
  bool isLoginSelected = true; // Tracks if Login is selected
  bool isRegisterSelected = false; // Tracks if Register is selected

  bool _obscurePassword = true; // For password visibility
  bool _obscureConfirmPassword = true; // For confirm password visibility

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Welcome Texts
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLoginSelected ? "Enjoy Our Service" : "Seller",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "We are always happy to serve you!",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Login and Register Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLoginSelected = true;
                                isRegisterSelected = false;
                              });
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                decoration: isLoginSelected
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                color: isLoginSelected
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isRegisterSelected = true;
                                isLoginSelected = false;
                              });
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 20,
                                decoration: isRegisterSelected
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                color: isRegisterSelected
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Conditional rendering of Register and Login forms
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Show Register Form if "Register" is selected
                            if (isRegisterSelected) ...[
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter full name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

                            // Common phone number field
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter phone number',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: isLoginSelected
                                    ? "Password"
                                    : "Enter password",
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 2),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _obscurePassword,
                            ),
                            const SizedBox(height: 20),

                            // Confirm Password Field for Register Only
                            if (isRegisterSelected)
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Confirm password",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _obscureConfirmPassword,
                              ),

                            const SizedBox(height: 30),

                            // Submit Button
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Navigate to the SellerDashboardScreen if login is selected
                                  if (isLoginSelected) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SellerDashboardScreen(), // Navigate to SellerDashboardScreen
                                      ),
                                    );
                                  }
                                  // Proceed with registration logic if needed
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 120, vertical: 20),
                                minimumSize: const Size(200, 20),
                              ),
                              child: Text(
                                isLoginSelected ? "Login" : "Register",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Image and Design
            Container(
              color: Colors.white, // Ensures the bottom background is white
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    'lib/images/img.png', // Replace with your image path
                    width: 300,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
