import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; // Animation package
import 'package:myproject/Screens/LoginAndSignUp/CustomerLoginScreen.dart';
import 'package:myproject/Screens/LoginAndSignUp/SellerLoginPageScreen.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0072FF),
                  Color(0xFF16AFDA),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Creative Header Section
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: FadeInDown(
                    duration: const Duration(seconds: 1),
                    child: Column(
                      children: const [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Choose your role to get started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 251, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Buttons Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    // Click as Customer Button
                    SlideInLeft(
                      duration: const Duration(seconds: 1),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerLoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person, color: Colors.blueAccent),
                              const SizedBox(width: 10),
                              Text(
                                'Click as Customer',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // OR with Divider Line
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 40,
                                endIndent: 10),
                          ),
                          const Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 10,
                                endIndent: 40),
                          ),
                        ],
                      ),
                    ),

                    // Click as Seller Button
                    SlideInRight(
                      duration: const Duration(seconds: 2),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Sellerloginpagescreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.store, color: Colors.blueAccent),
                              const SizedBox(width: 10),
                              Text(
                                'Click as Seller',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
        ],
      ),
    );
  }
}
