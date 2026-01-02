import 'package:cvd_sim/data/cvd_types.dart';
import 'package:cvd_sim/ui/widget/simulator/filter_button.dart';
import 'package:cvd_sim/widget/button.dart';
import 'package:flutter/material.dart';
import '../widget/simulator/SimulationCameraSection.dart';
import '../../models/simulationMode.dart';
import '../widget/simulator/simulationAppBar.dart';
import 'package:go_router/go_router.dart';
import '../../models/CVDType.dart';

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  SimulationMode _mode = SimulationMode.single;
  late CVDType _selectedType;
  late CVDType _selectedTypeBottom;

  void _onModeChanged(SimulationMode mode) {
    setState(() => _mode = mode);
  }

  @override
  void initState() {
    super.initState();
    _selectedType = cvdTypeData.first;
    _selectedTypeBottom = cvdTypeData.first;
  }

  void _onSelectedType(CVDType type) {
    setState(() {
      _selectedType = type;
    });
  }

  void _onSelectedTypeBottom(CVDType type) {
    setState(() {
      _selectedTypeBottom = type;
    });
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
              SimulationAppBar(mode: _mode, onModeChanged: _onModeChanged),
              const SizedBox(height: 20),
              SizedBox(
                height: 420,
                child: SimulationCameraSection(
                  mode: _mode,
                  cvdType: _selectedType,
                  bottomCvdType: _selectedTypeBottom,
                ),
              ),
              FilterButtonRow(
                cvdType: cvdTypeData,
                selectedType: _selectedType,
                selectedTypeBottom: _selectedTypeBottom,
                onTypeSelected: _onSelectedType,
                onTypeSelectedBottom: _onSelectedTypeBottom,
                mode: _mode,
              ),
              const Spacer(),
              AppButton(
                label: "Go to gallery",
                onPressed: () => context.push('/gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
