import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatefulWidget {
  final CameraDescription camera;
  final double widthFactor; // 0.0 to 1.0, percentage of screen width
  final double aspectRatio;
  final BorderRadius? borderRadius;

  const CameraPreviewWidget({
    super.key,
    required this.camera,
    this.widthFactor = 0.85,
    this.aspectRatio = 3 / 4,
    this.borderRadius,
  });

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
    final previewWidth = screenWidth * widget.widthFactor;
    

    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            width: previewWidth,
            child: ClipRRect(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: _cameraController.value.previewSize?.height ?? 1,
                    height: _cameraController.value.previewSize?.width ?? 1,
                    child: CameraPreview(_cameraController),
                  ),
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            width: previewWidth,
            child: AspectRatio(
              aspectRatio: widget.aspectRatio,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
