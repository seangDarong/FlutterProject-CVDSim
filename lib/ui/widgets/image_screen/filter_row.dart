import 'package:flutter/material.dart';
import '../../../data/cvd_types.dart';
import '../../../models/cvd_type.dart';

class FilterRow extends StatelessWidget {
  final CVDType currentFilter;
  final ValueChanged<CVDType> onFilterSelected;

  const FilterRow({
    super.key,
    required this.currentFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cvdTypeData.map(_buildFilterButton).toList(),
    );
  }

  Widget _buildFilterButton(CVDType type) {
    final bool isSelected = type.id == currentFilter.id;
    const primaryColor = Color(0xFF4DB6AC);

    return GestureDetector(
      onTap: () => onFilterSelected(type),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            _buildIcon(primaryColor),
            const SizedBox(height: 4),
            Text(
              type.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'DMSans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.remove_red_eye,
        color: Colors.white,
        size: 12,
      ),
    );
  }
}
