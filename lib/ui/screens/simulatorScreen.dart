import 'package:cvd_sim/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Simulator screen placeholder'),
            AppButton(label: "Go to gallery", onPressed: () => context.go('/gallery')),
          ],
        ),
      ),
    );
  }
}
