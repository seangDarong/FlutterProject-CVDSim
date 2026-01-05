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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _action('Save', onSave),
        _action(
          'Compare',
          onCompareToggle,
          active: compareMode,
        ),
        _action('Delete', onDelete, danger: true),
      ],
    );
  }

  Widget _action(
    String label,
    VoidCallback onTap, {
    bool active = false,
    bool danger = false, 
  }) {
    const primaryColor = Color(0xFF4DB6AC);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? primaryColor
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: danger
                ? Colors.red
                : active
                    ? primaryColor
                    : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 13,
              color: danger ? Colors.red : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}