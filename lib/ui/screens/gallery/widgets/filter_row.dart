import 'package:flutter/material.dart';
import '../../../../utils/cvd_filters.dart';

class FilterRow extends StatelessWidget {
  final List<double>? currentFilter;
  final ValueChanged<List<double>> onFilterSelected;

  const FilterRow({
    super.key,
    required this.currentFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _filterButton('Normal', CVDFilters.normal),
        _filterButton('Protanopia', CVDFilters.protanopia),
        _filterButton('Deuteranopia', CVDFilters.deuteranopia),
        _filterButton('Tritanopia', CVDFilters.tritanopia),
      ],
    );
  }

  Widget _filterButton(String label, List<double> filter) {
    final bool isSelected = identical(currentFilter, filter);
    const primaryColor = Color(0xFF4DB6AC);

    return GestureDetector(
      onTap: () => onFilterSelected(filter),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withOpacity(0.1)
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
              label,
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
  }
}