import 'package:cvd_sim/ui/screens/gallery/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cvd_sim/ui/screens/landingScreen.dart';
import 'package:cvd_sim/ui/screens/simulatorScreen.dart';
import 'package:cvd_sim/ui/screens/homeScreen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     final available = await availableCameras();
//     var cameras;
//     cameras.addAll(available); // populate the global cameras list
//   } catch (e) {
//     // ignore: avoid_print
//     print('Error fetching cameras: $e');
//   }
//   runApp(const MyApp());
// }

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
    GoRoute(
      path: '/gallery',
      builder: (context, state) => const GalleryScreen(),
    )
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
