import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_compare_slider/image_compare_slider.dart';
import '../../../../models/captured_image.dart';

class ImageViewer extends StatelessWidget {
  final List<CapturedImage> images;
  final PageController controller;
  final bool compareMode;
  final List<double>? currentFilter;
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
    return PageView.builder(
      controller: controller,
      physics: compareMode
          ? const NeverScrollableScrollPhysics()
          : const PageScrollPhysics(),
      itemCount: images.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        final image = images[index];
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _buildImage(image),
          ),
        );
      },
    );
  }

  Widget _buildImage(CapturedImage image) {
    final baseImage = Image.file(File(image.imagePath));

    if (currentFilter == null) {
      return baseImage;
    }

    if (compareMode) {
      return ImageCompareSlider(
        itemOne: baseImage,
        itemTwo: baseImage,
        itemTwoBuilder: (child, _) => ColorFiltered(
          colorFilter: ColorFilter.matrix(currentFilter!),
          child: child,
        ),
      );
    }

    return ColorFiltered(
      colorFilter: ColorFilter.matrix(currentFilter!),
      child: baseImage,
    );
  }
}
