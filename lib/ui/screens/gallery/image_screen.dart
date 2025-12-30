import 'package:flutter/material.dart';
import '../../../models/capturedImage.dart';
import '../../../models/simulationMode.dart';
import '../../../models/cvdType.dart';

class ImageScreen extends StatefulWidget {
  final CapturedImage image;

  const ImageScreen({super.key, required this.image});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  SimulationMode mode = SimulationMode.single;

  late CVDType currentFilter;

  @override
  void initState() {
    super.initState();
    currentFilter = normalFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // Active filter label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Text(
              currentFilter.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 16),

          // Image display
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(currentFilter.matrix),
                  child: Image.asset(
                    widget.image.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Filter buttons
          _buildFilterButtons(),

          const SizedBox(height: 20),

          // Bottom actions (placeholders)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionButton('Save to Device'),
                _actionButton('Delete'),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // UI helpers
  // ─────────────────────────────────────────────────────────────

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _filterButton(normalFilter),
        _filterButton(protanopiaFilter),
        _filterButton(deuteranopiaFilter),
        _filterButton(tritanopiaFilter),
      ],
    );
  }

  Widget _filterButton(CVDType filter) {
    final bool isActive = currentFilter.id == filter.id;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          currentFilter = filter;
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

  Widget _actionButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label),
    );
  }
}

//
// ─────────────────────────────────────────────────────────────
// Temporary filter definitions (single mode only)
// These can be moved to a shared file later
// ─────────────────────────────────────────────────────────────
//

final normalFilter = CVDType(
  id: 'normal',
  name: 'Normal',
  description: 'Normal vision',
  matrix: const [
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ],
);

final protanopiaFilter = CVDType(
  id: 'protanopia',
  name: 'Protanopia',
  description: '',
  matrix: const [
    0.567, 0.433, 0, 0, 0,
    0.558, 0.442, 0, 0, 0,
    0, 0.242, 0.758, 0, 0,
    0, 0, 0, 1, 0,
  ],
);

final deuteranopiaFilter = CVDType(
  id: 'deuteranopia',
  name: 'Deuteranopia',
  description: '',
  matrix: const [
    0.625, 0.375, 0, 0, 0,
    0.7, 0.3, 0, 0, 0,
    0, 0.3, 0.7, 0, 0,
    0, 0, 0, 1, 0,
  ],
);

final tritanopiaFilter = CVDType(
  id: 'tritanopia',
  name: 'Tritanopia',
  description: '',
  matrix: const [
    0.95, 0.05, 0, 0, 0,
    0, 0.433, 0.567, 0, 0,
    0, 0.475, 0.525, 0, 0,
    0, 0, 0, 1, 0,
  ],
);
