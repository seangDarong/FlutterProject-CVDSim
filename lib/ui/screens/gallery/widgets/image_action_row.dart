import 'package:flutter/material.dart';

class ImageActionsRow extends StatelessWidget {
  final bool compareMode;
  final VoidCallback onCompareToggle;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const ImageActionsRow({
    super.key,
    required this.compareMode,
    required this.onCompareToggle,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _actionButton('Save', onSave)),
        const SizedBox(width: 10),
        Expanded(child: _compareButton()),
        const SizedBox(width: 10),
        Expanded(child: _actionButton('Delete', onDelete)),
      ],
    );
  }

  Widget _actionButton(String label, VoidCallback onPressed) {
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

  Widget _compareButton() {
    return ElevatedButton(
      onPressed: onCompareToggle,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            compareMode ? Colors.blue : Colors.grey.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text('Compare'),
    );
  }
}
