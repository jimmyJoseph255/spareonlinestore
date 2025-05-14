import 'package:flutter/material.dart';
import 'package:myproject/Screens/Role/ChooseRole.dart';
import 'package:confetti/confetti.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ConfettiController _confettiController;
  late AnimationController _bubbleController;
  late Animation<double> _bubbleAnimation;

  @override
  void initState() {
    super.initState();

    // Floating car animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.0,
      upperBound: 10.0,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 10).animate(_controller);

    // Confetti animation
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    // Bubble button animation
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _bubbleAnimation =
        Tween<double>(begin: 0, end: 10).animate(_bubbleController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0072FF), Color(0xFF16AFDA)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Confetti Celebration
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: false,
                        colors: const [
                          Colors.red,
                          Colors.green,
                          Colors.blue,
                          Colors.orange
                        ],
                      ),
                    ),

                    // Animated Car Image (near the top)
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _animation.value),
                          child: Image.asset(
                            'lib/images/car.png',
                            width: 300,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Welcome Text with Fade-in Effect (below the car image)
                    TweenAnimationBuilder(
                      duration: const Duration(seconds: 2),
                      tween: Tween<double>(begin: 0, end: 1),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: const Text(
                            "Spare Faster",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    // Description Text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "Get quality spare parts delivered to your doorstep with ease!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 251, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // "Let's Get Started" Bubble Button
                    AnimatedBuilder(
                      animation: _bubbleAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bubbleAnimation.value),
                          child: GestureDetector(
                            onTap: () {
                              _confettiController.play();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChooseRole(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 255, 255, 255)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Let's Get Started",
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18,
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
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
