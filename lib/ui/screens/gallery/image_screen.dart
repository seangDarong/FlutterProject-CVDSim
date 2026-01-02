import 'package:flutter/material.dart';
import 'package:image_compare_slider/image_compare_slider.dart';
import '../../../models/capturedImage.dart';
import '../../../models/CVDType.dart';
import '../../../utils/cvd_filters.dart';

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

  CVDType? currentFilter;
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
              child: PageView.builder(
                controller: _pageController,
                physics: compareMode
                    ? const NeverScrollableScrollPhysics()
                    : const PageScrollPhysics(),
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                    currentFilter = null;
                    compareMode = false;
                  });
                },
                itemBuilder: (context, index) {
                  final image = widget.images[index];
                  return Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _buildImageView(image),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            _buildFilterButtons(),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionButton(label: 'Save', onPressed: _savePlaceholder),
                _compareToggle(),
                _actionButton(label: 'Delete', onPressed: _showDeleteDialog),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildImageView(CapturedImage image) {
    if (currentFilter == null) {
      return Image.asset(image.imagePath, fit: BoxFit.contain);
    }

    if (compareMode) {
      return ImageCompareSlider(
        itemOne: Image.asset(image.imagePath, fit: BoxFit.contain),
        itemTwo: Image.asset(image.imagePath, fit: BoxFit.contain),
        itemTwoBuilder: (child, context) {
          return ColorFiltered(
            colorFilter: ColorFilter.matrix(currentFilter!.matrix),
            child: child,
          );
        },
      );
    }

    return ColorFiltered(
      colorFilter: ColorFilter.matrix(currentFilter!.matrix),
      child: Image.asset(image.imagePath, fit: BoxFit.contain),
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _filterButton(protanopiaFilter),
        _filterButton(deuteranopiaFilter),
        _filterButton(tritanopiaFilter),
      ],
    );
  }

  Widget _filterButton(CVDType filter) {
    final bool isActive = currentFilter?.id == filter.id;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          currentFilter = isActive ? null : filter;
          // compareMode intentionally preserved
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.green : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(filter.name),
    );
  }

  Widget _compareToggle() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (currentFilter == null) {
            currentFilter = protanopiaFilter; // default
          }
          compareMode = !compareMode;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: compareMode ? Colors.blue : Colors.grey.shade600,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text('Compare'),
    );
  }

  Widget _actionButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }

  void _savePlaceholder() {}

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete image?'),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Delete',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

// Filters unchanged
final protanopiaFilter = CVDType(
  id: 'protanopia',
  name: 'Protanopia',
  description: '',
  prevalence: '',
  affected: '',
  matrix: CVDFilters.protanopia,
);

final deuteranopiaFilter = CVDType(
  id: 'deuteranopia',
  name: 'Deuteranopia',
  description: '',
    prevalence: '',
  affected: '',
  matrix: CVDFilters.deuteranopia,
);

final tritanopiaFilter = CVDType(
  id: 'tritanopia',
  name: 'Tritanopia',
  description: '',
    prevalence: '',
  affected: '',
  matrix: CVDFilters.tritanopia,
);
