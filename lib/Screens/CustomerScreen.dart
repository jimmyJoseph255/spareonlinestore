import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'DashboardScreen.dart';
import 'package:animate_do/animate_do.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  bool isLoginSelected = true;
  bool isRegisterSelected = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();

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
        child: SafeArea(
          child: FadeInUp(
            duration: const Duration(seconds: 1),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Welcome Texts
                          FadeInLeft(
                            duration: const Duration(seconds: 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isLoginSelected
                                      ? "Please login "
                                      : "Register Now",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "We are always happy to serve you!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Login and Register Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeInLeft(
                                duration: const Duration(seconds: 1),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLoginSelected = true;
                                      isRegisterSelected = false;
                                    });
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 22,
                                      decoration: isLoginSelected
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      decorationColor: isLoginSelected
                                          ? Colors.white
                                          : Colors.transparent,
                                      color: isLoginSelected
                                          ? Colors.white
                                          : Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50),
                              FadeInRight(
                                duration: const Duration(seconds: 1),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isRegisterSelected = true;
                                      isLoginSelected = false;
                                    });
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 22,
                                      decoration: isRegisterSelected
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      decorationColor: isRegisterSelected
                                          ? Colors.white
                                          : Colors.transparent,
                                      color: isRegisterSelected
                                          ? Colors.white
                                          : Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          // Conditional rendering of Register and Login forms
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Show Register Form if "Register" is selected
                                if (isRegisterSelected) ...[
                                  FadeInLeft(
                                    duration: const Duration(seconds: 1),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter full name',
                                        hintStyle: const TextStyle(
                                            color: Colors.white70),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],

                                // Common phone number field
                                FadeInLeft(
                                  duration: const Duration(seconds: 1),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter phone number',
                                      hintStyle: const TextStyle(
                                          color: Colors.white70),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Password Field
                                FadeInLeft(
                                  duration: const Duration(seconds: 1),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: isLoginSelected
                                          ? "Password"
                                          : "Enter password",
                                      hintStyle: const TextStyle(
                                          color: Colors.white70),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: _obscurePassword,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Confirm Password Field for Register Only
                                if (isRegisterSelected)
                                  FadeInLeft(
                                    duration: const Duration(seconds: 1),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Confirm password",
                                        hintStyle: const TextStyle(
                                            color: Colors.white70),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureConfirmPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.white,
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
                                  ),

                                const SizedBox(height: 30),

                                // Submit Button with a gradient background and bounce effect
                                BounceIn(
                                  duration: const Duration(seconds: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (isLoginSelected) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const DashboardScreen(),
                                            ),
                                          );
                                        } else if (isRegisterSelected) {
                                          // Show the success message when register is selected
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "You have successfully registered"),
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                          // After showing the message, you can navigate if needed
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => const DashboardScreen(),
                                          //   ),
                                          // );
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 255, 255, 255),
                                            Color.fromARGB(255, 255, 255, 255),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueAccent
                                                .withOpacity(0.5),
                                            blurRadius: 10,
                                            spreadRadius: 3,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          isLoginSelected
                                              ? "Login"
                                              : "Register",
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                offset: const Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Wave Animation
                Container(
                  height: 100,
                  width: double.infinity,
                  child: WaveWidget(
                    config: CustomConfig(
                      gradients: [
                        [Colors.white, Colors.white70],
                        [Colors.white70, Colors.white54],
                      ],
                      durations: [5000, 4000],
                      heightPercentages: [0.20, 0.23],
                      blur: MaskFilter.blur(BlurStyle.solid, 5),
                    ),
                    waveAmplitude: 10,
                    size: const Size(double.infinity, double.infinity),
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
