import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/simulationMode.dart';
import 'modeToggle.dart';

class SimulationAppBar extends StatelessWidget {
  final SimulationMode mode;
  final ValueChanged<SimulationMode> onModeChanged;

  const SimulationAppBar({
    super.key,
    required this.mode,
    required this.onModeChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => context.go('/home'),
          child: Icon(Icons.arrow_back_ios)
        ),
        
        const Text(
          'Simulation',
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        

        ModeToggle(currentMode: mode, 
        onModeChanged: onModeChanged),
      ],
    );
  }
}
