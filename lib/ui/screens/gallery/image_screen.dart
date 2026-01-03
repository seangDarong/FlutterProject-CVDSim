import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../models/stored_image.dart';
import '../../../models/cvd_type.dart';
import '../../../models/image_session.dart';
import '../../../data/cvd_types.dart';
import 'widgets/image_viewer.dart';
import 'widgets/filter_row.dart';
import 'widgets/image_action_row.dart';

class ImageScreen extends StatefulWidget {
  final List<StoredImage> images;
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
  late ImageSession session;

  @override
  void initState() {
    super.initState();

    session = ImageSession.initial(
      widget.initialIndex,
      cvdTypeData.first, // Normal
    );

    _pageController = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      session = session.copyWith(
        index: index,
        compare: false, // compare always exits on swipe
      );
    });
  }

  void _showSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message, textAlign: TextAlign.center),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete image?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteImageConfirmed();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _saveImage(StoredImage image) async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      _showSnackBar('Photo permission denied');
      return;
    }

    try {
      final bytes = await File(image.filePath).readAsBytes();
      await PhotoManager.editor.saveImage(
        bytes,
        filename: 'cvd_${image.id}.jpg',
      );
      _showSnackBar('Saved to Photos');
    } catch (_) {
      _showSnackBar('Failed to save image');
    }
  }

  Future<void> _deleteImageConfirmed() async {
    final imageToDelete = widget.images[session.index];

    try {
      await File(imageToDelete.filePath).delete();
    } catch (_) {
      _showSnackBar('Failed to delete image');
      return;
    }

    if (!mounted) return;

    _showSnackBar('Image deleted');
    Navigator.pop(context, imageToDelete.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: ImageViewer(
                images: widget.images,
                controller: _pageController,
                compareMode: session.compare,
                currentFilter: session.filter,
                onPageChanged: _onPageChanged,
              ),
            ),
            const SizedBox(height: 20),
            FilterRow(
              currentFilter: session.filter,
              onFilterSelected: (type) {
                setState(() {
                  session = session.copyWith(filter: type);
                });
              },
            ),
            const SizedBox(height: 20),
            ImageActionsRow(
              compareMode: session.compare,
              onCompareToggle: () {
                setState(() {
                  session = session.copyWith(
                    compare: !session.compare,
                  );
                });
              },
              onSave: () => _saveImage(widget.images[session.index]),
              onDelete: _confirmDelete,
            ),
          ],
        ),
      ),
    );
  }
}
