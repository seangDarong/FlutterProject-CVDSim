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
    final loadedImages = await ImageStoring.loadImages(); //return the list of storedimages with func from imagestoring
    setState(() {
      images = loadedImages; //initially or update the images list with our loaded images
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } //loading screen

    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: images.isEmpty
          ? const Center(child: Text('No images yet')) //if no images
          : GridView.builder( //grid layout for consistency 
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

                //what is happening here with smth smth deleted image huh?
                //perhaps up this to a function upstairs? kinda hard for me 
                //but i can tell that this is the on tap go to imagescreen, i just dont know what the deleted image id thing is for and why it's encompasing the nav too?
                //basically nav push normal stuff, but can also have a future to recieve a value in imagescreen
                //this value determines whether we reload below this block, if the returned value is null reload if not, not type shi
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

                    //idk what this is too, but i can kinda assume if it cant find said image or object or block anymore itll trigger loadimage which updates our list to display images
                    //wait hold on this whole freaking deleted image thing is encompasing the nav too like i mention on top why is it's typep string and what info or string is it storing
                    //understood now
                    if (deletedImageId != null) {
                      await _loadImages();
                    }
                  },

                  //the image block
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
