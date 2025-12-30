import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimulatorScreen extends StatelessWidget {
  const SimulatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Home'),
      ),
      body: const Center(child: Text('Simulator screen placeholder')),
    );
  }
}
