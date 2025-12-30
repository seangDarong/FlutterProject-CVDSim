import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/mock_images.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images = mockImages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: images.isEmpty
          ? const Center(child: Text('No images yet'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: images.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final image = images[index];

                return GestureDetector(
                  onTap: () {
                    context.push('/images', extra: image);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      image.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
