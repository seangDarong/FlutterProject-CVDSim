import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  static const Color primaryColor = Color(0xFF1BA38C);
  static const Color innerBackground = Color(0xFFF7F9FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 720),
              width: double.infinity,
              decoration: BoxDecoration(
                color: innerBackground,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.fromLTRB(32.0, 40.0, 32.0, 24.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Large icon
                      Icon(
                          Icons.remove_red_eye,
                          size: 200,
                          color: primaryColor,
                      ),
                      const SizedBox(height: 24),
                      // Big welcome text
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'CVDSim',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  // Start button aligned bottom-right
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12.0,
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
