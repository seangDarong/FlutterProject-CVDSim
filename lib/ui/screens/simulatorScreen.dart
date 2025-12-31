import 'package:cvd_sim/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../widget/simulator/camera_preview_widget.dart';
import '../../models/simulationMode.dart';
import '../widget/simulator/simulationAppBar.dart';
import 'package:go_router/go_router.dart';

final List<CameraDescription> cameras = [];

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  SimulationMode _mode = SimulationMode.single;

  void _onModeChanged(SimulationMode mode) {
    setState(() => _mode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              SimulationAppBar(
                mode: _mode,
                onModeChanged: _onModeChanged,
              ),
              const SizedBox(height: 20),

              if (cameras.isNotEmpty)
                CameraPreviewWidget(camera: cameras[0])
              else
                const Text('No camera available'),

              const Spacer(),
              AppButton(
                label: "Go to gallery",
                onPressed: () => context.go('/gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
