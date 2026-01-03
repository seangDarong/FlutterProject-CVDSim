import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cvd_sim/widget/button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  static const Color primaryColor = Color(0xFF1BA38C);
  static const Color innerBackground = Color(0xFFF7F9FA);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _iconScale;
  late final Animation<double> _iconFade;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _buttonFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _iconScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _iconFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.45, curve: Curves.easeIn)),
    );

    _textSlide = Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.75, curve: Curves.easeOut)),
    );

    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.75, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goHome() => context.go('/home');

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
                color: LandingScreen.innerBackground,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.fromLTRB(32.0, 40.0, 32.0, 24.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Animated Icon: Fade + Scale, wrapped in Hero
                      FadeTransition(
                        opacity: _iconFade,
                        child: ScaleTransition(
                          scale: _iconScale,
                          child: Hero(
                            tag: 'eye-logo',
                            child: Icon(
                              Icons.remove_red_eye,
                              size: 200,
                              color: LandingScreen.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SlideTransition(
                        position: _textSlide,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'See the world differently',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Experience and understand color vision deficiency\nthrough simulation.',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            

                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),

                  
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: FadeTransition(
                      opacity: _buttonFade,
                      child: AppButton(
                        label: 'Try the simulation',
                        onPressed: _goHome,
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
