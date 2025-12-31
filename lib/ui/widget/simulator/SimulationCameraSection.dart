import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../../models/simulationMode.dart';

class SimulationCameraSection extends StatefulWidget {
  final SimulationMode mode;
  const SimulationCameraSection({super.key, required this.mode});

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
    double widthFactor,
    double aspectRatio, [
    BorderRadius? borderRadius,
  ]) {
    final screenWidth = MediaQuery.of(context).size.width;
    final previewWidth = screenWidth * widthFactor;

    return SizedBox(
      width: previewWidth,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: _cameraController!.value.previewSize?.height ?? 1,
              height: _cameraController!.value.previewSize?.width ?? 1,
              child: CameraPreview(_cameraController!),
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

    // Single mode - one large preview
    if (widget.mode == SimulationMode.single) {
      return _buildCameraPreview(0.85, 3 / 4);
    }

    // Compare mode - two previews using the SAME controller
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCameraPreview(
          0.85,
          3 / 2,
          BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(12)),
        ),
        _buildCameraPreview(0.85, 3 / 2,
        BorderRadius.vertical(top: Radius.circular(0),bottom: Radius.circular(12))),
      ],
    );
  }
}
