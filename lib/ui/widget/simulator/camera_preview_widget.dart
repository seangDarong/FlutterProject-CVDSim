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
  void initState(){
    super.initState();

    _cameraController = CameraController(
      widget.camera
      ,ResolutionPreset.medium
      );
      _initializeControllerFuture = _cameraController.initialize();
      
  }

  @override
  void dispose() {
    _cameraController.dispose();
  }

  @override 
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: CameraPreview(_cameraController),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}