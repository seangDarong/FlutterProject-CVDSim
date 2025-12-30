import 'package:flutter/material.dart';
import '../../../models/capturedImage.dart';
import '../../../models/simulationMode.dart';

class ImageScreen extends StatefulWidget {
  final CapturedImage image;

  const ImageScreen({super.key, required this.image});

  @override
  State<ImageScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageScreen> {
  SimulationMode mode = SimulationMode.single;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
        actions: [
          IconButton(
            icon: Icon(
              mode == SimulationMode.single
                  ? Icons.compare
                  : Icons.crop_square,
            ),
            onPressed: () {
              setState(() {
                mode = mode == SimulationMode.single
                    ? SimulationMode.dual
                    : SimulationMode.single;
              });
            },
          ),
        ],
      ),
      body: mode == SimulationMode.single
          ? _buildSingleView()
          : _buildDualView(),
    );
  }

  Widget _buildSingleView() {
  return Center(
    child: Image.asset(
      widget.image.imagePath,
      fit: BoxFit.contain,
    ),
  );
}

  Widget _buildDualView() {
    return Column(
      children: [
        Expanded(child: _buildComparePane('Top')),
        Expanded(child: _buildComparePane('Bottom')),
      ],
    );
  }

  Widget _buildComparePane(String label) {
    return Container(
      margin: const EdgeInsets.all(8),
      color: Colors.black12,
      child: Center(child: Text(label)),
    );
  }
}
