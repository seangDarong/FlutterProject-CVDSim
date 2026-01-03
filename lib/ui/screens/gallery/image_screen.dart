import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../models/captured_image.dart';
import '../../../../utils/cvd_filters.dart';
import 'widgets/image_viewer.dart';
import 'widgets/filter_row.dart';
import 'widgets/image_action_row.dart';

class ImageScreen extends StatefulWidget {
  final List<CapturedImage> images;
  final int initialIndex;

  const ImageScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late final PageController _pageController;

  int currentIndex = 0;
  List<double>? currentFilter;
  bool compareMode = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      currentFilter = null;
      compareMode = false;
    });
  }

  // void _showSnackBar(String message) {
  //   if (!mounted) return;
  //   ScaffoldMessenger.of(context)
  //     ..clearSnackBars()
  //     ..showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  // }
  void _showSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message, textAlign: TextAlign.center),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(
            horizontal: 60, // controls width
            vertical: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
  }

  Future<void> _saveImage(CapturedImage image) async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      _showSnackBar('Photo permission denied');
      return;
    }

    try {
      final bytes = await File(image.imagePath).readAsBytes();
      await PhotoManager.editor.saveImage(
        bytes,
        filename: 'cvd_${image.id}.jpg',
      );
      _showSnackBar('Saved to Photos');
    } catch (_) {
      _showSnackBar('Failed to save image');
    }
  }

  Future<void> _deleteImage() async {
    final image = widget.images[currentIndex];

    try {
      await File(image.imagePath).delete();
      _showSnackBar('Image deleted');

      // Tell gallery to refresh
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (_) {
      _showSnackBar('Failed to delete image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Expanded(
              child: ImageViewer(
                images: widget.images,
                controller: _pageController,
                compareMode: compareMode,
                currentFilter: currentFilter,
                onPageChanged: _onPageChanged,
              ),
            ),

            const SizedBox(height: 20),

            FilterRow(
              currentFilter: currentFilter,
              onFilterSelected: (filter) {
                setState(() {
                  currentFilter = currentFilter == filter ? null : filter;
                });
              },
            ),

            const SizedBox(height: 20),

            ImageActionsRow(
              compareMode: compareMode,
              onCompareToggle: () {
                setState(() {
                  currentFilter ??= CVDFilters.protanopia;
                  compareMode = !compareMode;
                });
              },
              onSave: () => _saveImage(widget.images[currentIndex]),
              onDelete: _deleteImage,
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
