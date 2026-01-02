import 'package:flutter/material.dart';
import '../../../models/simulation_mode.dart';
import 'modeButton.dart';

class ModeToggle extends StatelessWidget {
  final SimulationMode currentMode;
  final ValueChanged<SimulationMode> onModeChanged;

  const ModeToggle({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModeButton(
            label: 'Single',
            mode: SimulationMode.single,
            currentMode: currentMode,
            onTap: onModeChanged,
          ),
          ModeButton(
            label: 'Compare',
            mode: SimulationMode.dual,
            currentMode: currentMode,
            onTap: onModeChanged,
          ),
        ],
      ),
    );
  }
}
