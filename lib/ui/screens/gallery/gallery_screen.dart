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
  List<StoredImage> images = []; //to store storedimages
  bool loading = true; //for loading screen

  Future<void> _loadImages() async {
    final loadedImages =
        await ImageStoring.loadImages(); //return the list of storedimages with func from imagestoring
    setState(() {
      images =
          loadedImages; //initially or update the images list with our loaded images
      loading = false; //when done loading no more loading screen
    });
  } //

  @override
  void initState() {
    super.initState();
    _loadImages();
  } //for the initial load

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } //loading screen

    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: images.isEmpty
          ? const Center(child: Text('No images yet')) //if no images
          : GridView.builder(
              //grid layout for consistency
              padding: const EdgeInsets.all(10),
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ), //how we want our layout to look
              itemBuilder: (context, index) {
                final image = images[index];
                return GestureDetector(
                  //basically nav push normal stuff, but can also a recieve a future string from imagescreen
                  //this value determines whether we reload below this block
                  onTap: () async {
                    final deletedImageId = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ImageScreen(images: images, initialIndex: index),
                      ),
                    );

                    //if the returned value is not null, reload
                    //if null nth happen in ba sing se
                    if (deletedImageId != null) {
                      await _loadImages();
                    }
                  },

                  //the image block
                  child: Container(
                    // tag: image.id,
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
