//test
import 'dart:typed_data';
import 'package:cvd_sim/utils/image_storing.dart';
//test

import 'package:camera/camera.dart';
import 'package:cvd_sim/models/cvd_type.dart';
import 'package:flutter/material.dart';
import '../../../models/simulation_mode.dart';

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
      SimulationCameraSectionState();
}

class SimulationCameraSectionState extends State<SimulationCameraSection> {
  CameraController? _cameraController;
  bool _loading = true;
  List<CameraDescription> _cameras = [];
  int _currentCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final allCameras = await availableCameras();
    if (allCameras.isEmpty) {
      setState(() => _loading = false);
      return;
    }

    // Filter to get only one back and one front camera (1x lens)
    CameraDescription? backCamera;
    CameraDescription? frontCamera;

    for (final camera in allCameras) {
      if (camera.lensDirection == CameraLensDirection.back &&
          backCamera == null) {
        backCamera = camera; // First back camera (usually 1x)
      } else if (camera.lensDirection == CameraLensDirection.front &&
          frontCamera == null) {
        frontCamera = camera; // First front camera
      }
    }

    // Add cameras in order: back first, then front
    if (backCamera != null) _cameras.add(backCamera);
    if (frontCamera != null) _cameras.add(frontCamera);

    if (_cameras.isEmpty) {
      setState(() => _loading = false);
      return;
    }

    await _setupCamera(_currentCameraIndex);
  }

  Future<void> _setupCamera(int cameraIndex) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }

    _cameraController = CameraController(
      _cameras[cameraIndex],
      // ResolutionPreset.high,
      //test
      ResolutionPreset.medium,
      //test
      enableAudio: false,
    );

    await _cameraController!.initialize();
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;

    setState(() {
      _loading = true;
    });

    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
    await _setupCamera(_currentCameraIndex);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  //test
  Future<void> takePictureAndSave() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _cameraController!.value.isTakingPicture) {
      return;
    }

    final XFile file = await _cameraController!.takePicture();
    final Uint8List bytes = await file.readAsBytes();

    await ImageStoring.saveImage(bytes);
  }

//test

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
