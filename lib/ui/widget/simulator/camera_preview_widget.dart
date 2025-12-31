import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatefulWidget {
  final CameraDescription camera;
  const CameraPreviewWidget({super.key, required this.camera});

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false, // disable audio, only picture needed
    );
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final previewWidth = screenWidth * 0.85; // 85% of screen width

    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            width: previewWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 3 / 4, // portrait ratio matching design
                child: CameraPreview(_cameraController),
              ),
            ),
          );
        } else {
          return SizedBox(
            width: previewWidth,
            child: const AspectRatio(
              aspectRatio: 3 / 4,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
