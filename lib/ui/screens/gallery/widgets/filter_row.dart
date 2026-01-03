import 'package:flutter/material.dart';
import '../../../../data/cvd_types.dart';
import '../../../../models/cvd_type.dart';

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
      children: cvdTypeData.map((type) {
        final isSelected = type.id == currentFilter.id;
        const primaryColor = Color(0xFF4DB6AC);

        return GestureDetector(
          onTap: () => onFilterSelected(type),
          child: Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? primaryColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? primaryColor : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'DMSans',
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
