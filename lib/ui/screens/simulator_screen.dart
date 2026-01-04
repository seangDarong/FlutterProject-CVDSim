import 'package:cvd_sim/data/cvd_types.dart';
import 'package:cvd_sim/ui/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import '../widgets/simulator/simulation_camera_section.dart';
import '../../models/simulation_mode.dart';
import '../widgets/simulator/simulation_app_bar.dart';
import 'package:go_router/go_router.dart';
import '../../models/cvd_type.dart';
import '../widgets/simulator/camera_control_bar.dart';
import '../widgets/simulator/filter_info_card.dart';
import 'package:flutter/services.dart';

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  SimulationMode _mode = SimulationMode.single;
  late CVDType _selectedType;
  late CVDType _selectedTypeBottom;
  final GlobalKey<SimulationCameraSectionState> _cameraKey = GlobalKey();

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

  void _onGallery() {
    setState(() {
      context.push('/gallery');
    });
  }

  void _onSwtichCamera() {
    _cameraKey.currentState?.switchCamera();
  }

  //test
  void _onTakePicture() async {
    HapticFeedback.lightImpact();
    await _cameraKey.currentState?.takePictureAndSave();
  }
  //test

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ), 
          child: Column(
            children: [
              SimulationAppBar(mode: _mode, onModeChanged: _onModeChanged),
              const SizedBox(height: 8), 
              SizedBox(
                height: 420,
                child: SimulationCameraSection(
                  key: _cameraKey,
                  mode: _mode,
                  // cvdType: _selectedType,
                  // bottomCvdType: _selectedTypeBottom,
                  //test
                  topFilter: _selectedType,
                  bottomFilter: _selectedTypeBottom,
                  //test
                ),
              ),
              const SizedBox(height: 4), // Reduced
              FilterButtonRow(
                cvdType: cvdTypeData,
                selectedType: _selectedType,
                selectedTypeBottom: _selectedTypeBottom,
                onTypeSelected: _onSelectedType,
                onTypeSelectedBottom: _onSelectedTypeBottom,
                mode: _mode,
              ),
              CameraControlBar(
                onSwitchCamera: _onSwtichCamera,
                // onTakePicture: () {},
                //test
                onTakePicture: _onTakePicture,
                //test
                onGallery: _onGallery,
              ),
              if (_mode == SimulationMode.single)
                Expanded(child: FilterInfoCard(cvdType: _selectedType)),
            ],
          ),
        ),
      ),
    );
  }
}
