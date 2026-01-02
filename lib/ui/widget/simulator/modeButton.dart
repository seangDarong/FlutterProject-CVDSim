import 'package:flutter/material.dart';
import '../../../models/simulation_mode.dart';

class ModeButton extends StatelessWidget {
  final String label;
  final SimulationMode mode;
  final SimulationMode currentMode;
  final ValueChanged<SimulationMode> onTap;

  const ModeButton({
    super.key,
    required this.label,
    required this.mode,
    required this.currentMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = mode == currentMode;

    return GestureDetector(
      onTap: () => onTap(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1BA38C) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
