import 'package:flutter/material.dart';

class CameraControlBar extends StatelessWidget {
  final VoidCallback onSwitchCamera;
  final VoidCallback onTakePicture;
  final VoidCallback onGallery;

  const CameraControlBar({
    super.key,
    required this.onSwitchCamera,
    required this.onTakePicture,
    required this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4DB6AC);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onSwitchCamera,
            child: const Icon(
              Icons.cameraswitch_outlined,
              color: Colors.black,
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: onTakePicture,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          GestureDetector(
            onTap: onGallery,
            child: const Icon(
              Icons.photo_library_outlined,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
