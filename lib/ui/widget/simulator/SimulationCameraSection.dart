import 'package:camera/camera.dart';
import 'package:cvd_sim/models/CVDType.dart';
import 'package:flutter/material.dart';
import '../../../models/simulationMode.dart';

class SimulationCameraSection extends StatefulWidget {
  final SimulationMode mode;
  final CVDType cvdType;
  final CVDType bottomCvdType;
  const SimulationCameraSection({
    super.key,
    required this.mode,
    required this.cvdType,
    required this.bottomCvdType,
  });

  @override
  State<SimulationCameraSection> createState() =>
      _SimulationCameraSectionState();
}

class _SimulationCameraSectionState extends State<SimulationCameraSection> {
  CameraController? _cameraController;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      setState(() => _loading = false);
      return;
    }

    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview(
    double width,
    double height,
    CVDType filterType, [
    BorderRadius? borderRadius,
  ]) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: width,
              height: width * _cameraController!.value.aspectRatio,
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix(filterType.matrix),
                child: CameraPreview(_cameraController!),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Center(child: Text('No camera available'));
    }

    
    if (widget.mode == SimulationMode.single) {
      return _buildCameraPreview(368, 420, widget.cvdType);
    }

    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCameraPreview(
          368,
          210,
          widget.cvdType,
          const BorderRadius.vertical(
            bottom: Radius.circular(0),
            top: Radius.circular(12),
          ),
        ),
        _buildCameraPreview(
          368,
          210,
          widget.bottomCvdType,
          const BorderRadius.vertical(
            top: Radius.circular(0),
            bottom: Radius.circular(12),
          ),
        ),
      ],
    );
  }
}
