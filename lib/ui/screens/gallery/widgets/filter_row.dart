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
      children: [
        Expanded(child: _button('Protanopia', CVDFilters.protanopia)),
        const SizedBox(width: 10),
        Expanded(child: _button('Deuteranopia', CVDFilters.deuteranopia)),
        const SizedBox(width: 10),
        Expanded(child: _button('Tritanopia', CVDFilters.tritanopia)),
      ],
    );
  }

  Widget _button(String label, List<double> filter) {
    final isActive = identical(currentFilter, filter);

    return ElevatedButton(
      onPressed: () => onFilterSelected(filter),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.green : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }
}
