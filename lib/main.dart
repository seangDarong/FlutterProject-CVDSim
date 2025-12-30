import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cvd_sim/ui/screens/landingScreen.dart';
import 'package:cvd_sim/ui/screens/simulatorScreen.dart';
import 'package:cvd_sim/ui/screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LandingScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/simulator',
      builder: (context, state) => const SimulatorScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'DMSans',
      ),
    );
  }
}
