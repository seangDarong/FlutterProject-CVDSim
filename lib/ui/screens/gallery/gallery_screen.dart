import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/stored_image.dart';
import '../../../utils/image_storing.dart';
import 'image_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<StoredImage> images = [];
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final image = images[index];

                return GestureDetector(
                  onTap: () async {
                    final deletedImageId =
                        await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImageScreen(
                          images: images,
                          initialIndex: index,
                        ),
                      ),
                    );

                    if (deletedImageId != null) {
                      await _loadImages();
                    }
                  },
                  child: Hero(
                    tag: image.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(image.filePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
