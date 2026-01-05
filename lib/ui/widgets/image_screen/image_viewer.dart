import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_compare_slider/image_compare_slider.dart';
import '../../../models/stored_image.dart';
import '../../../models/cvd_type.dart';

class ImageViewer extends StatelessWidget {
  final List<StoredImage> images;
  final PageController controller;
  final bool compareMode; 
  final CVDType currentFilter; 
  final ValueChanged<int> onPageChanged;

  const ImageViewer({
    super.key,
    required this.images,
    required this.controller,
    required this.compareMode,
    required this.currentFilter,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder( //the widget that handles the swiping stuff
      controller: controller,
      physics: compareMode //this where we decide to disable the page swipe based on our compare bool
          ? const NeverScrollableScrollPhysics()
          : const PageScrollPhysics(),
      itemCount: images.length,
      onPageChanged: onPageChanged, //voidcallback that passes index
      itemBuilder: (context, index) {
        final image = images[index];

        return ClipRRect(
          borderRadius: BorderRadius.circular(20), //the builder returns the image which is also another widget down below
          child: _buildImage(image),
        );
      },
    );
  }

  Widget _buildImage(StoredImage image) { //this what spawns the actual image block
    final baseImage = Image.file( //le image
      File(image.filePath),
      fit: BoxFit.cover,
    );

    if (compareMode) { //for our comparison which we used a package from the internet, aint building allat myself
      return ImageCompareSlider( 
        itemOne: baseImage,
        itemTwo: baseImage,
        itemTwoBuilder: (child, _) => ColorFiltered( //the fucntion provided itemone and itemtwo only accepts image, so we gotta custom build it if we wanna see the filterd image
          colorFilter: ColorFilter.matrix(currentFilter.matrix),
          child: child,
        ),
      );
    }

    return ColorFiltered( //else normal 
      colorFilter: ColorFilter.matrix(currentFilter.matrix),
      child: baseImage,
    );
  }
}
