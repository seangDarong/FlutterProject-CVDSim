// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../../data/mock_images.dart';
// import 'image_screen.dart';

// class GalleryScreen extends StatelessWidget {
//   const GalleryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final images = mockImages;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Gallery')),
//       body: images.isEmpty
//           ? const Center(child: Text('No images yet'))
//           : GridView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: images.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//               ),
//               itemBuilder: (context, index) {
//                 final image = images[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       CupertinoPageRoute(
//                         builder: (_) =>
//                             ImageScreen(images: images, initialIndex: index),
//                       ),
//                     );
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.asset(image.imagePath, fit: BoxFit.cover),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import '../../../models/captured_image.dart';
import '../../../utils/image_storing.dart';
import 'image_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<CapturedImage> images = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final loadedImages = await ImageStoring.loadImages();
    setState(() {
      images = loadedImages;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: images.isEmpty
          ? const Center(child: Text('No images yet'))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: images.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final image = images[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImageScreen(
                          images: images,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(image.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
