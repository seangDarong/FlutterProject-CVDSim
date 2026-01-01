import 'package:flutter/material.dart';
import '../../../models/capturedImage.dart';
import '../../../models/cvdType.dart';
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

  /// null = normal vision
  CVDType? currentFilter;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    currentFilter = null;

    _pageController = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: Padding( // ✅ uniform inset (same as gallery)
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ───────────────────────────
            // Swipeable image viewer
            // ───────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                    currentFilter = null;
                  });
                },
                itemBuilder: (context, index) {
                  final image = widget.images[index];

                  return Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: currentFilter == null
                          ? Image.asset(
                              image.imagePath,
                              fit: BoxFit.contain,
                            )
                          : ColorFiltered(
                              colorFilter: ColorFilter.matrix(
                                currentFilter!.matrix,
                              ),
                              child: Image.asset(
                                image.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // ───────────────────────────
            // Filter buttons
            // ───────────────────────────
            _buildFilterButtons(),

            const SizedBox(height: 20),

            // ───────────────────────────
            // Bottom actions
            // ───────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionButton(
                  label: 'Save to Device',
                  onPressed: _savePlaceholder,
                ),
                _actionButton(
                  label: 'Delete',
                  onPressed: _showDeleteDialog,
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // UI helpers
  // ─────────────────────────────────────────────

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
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.green : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(filter.name),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label),
    );
  }

  // ─────────────────────────────────────────────
  // Placeholders
  // ─────────────────────────────────────────────

  void _savePlaceholder() {
    // TODO:
    // Web (Chrome): trigger browser download
    // Mobile: save to gallery
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete image?'),
          content: const Text(
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO:
                // - Remove image from list
                // - Navigate back if list empty
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Filters
// ─────────────────────────────────────────────

final protanopiaFilter = CVDType(
  id: 'protanopia',
  name: 'Protanopia',
  description: '',
  matrix: CVDFilters.protanopia,
);

final deuteranopiaFilter = CVDType(
  id: 'deuteranopia',
  name: 'Deuteranopia',
  description: '',
  matrix: CVDFilters.deuteranopia,
);

final tritanopiaFilter = CVDType(
  id: 'tritanopia',
  name: 'Tritanopia',
  description: '',
  matrix: CVDFilters.tritanopia,
);
