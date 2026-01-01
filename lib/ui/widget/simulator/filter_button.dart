import 'package:flutter/material.dart';
import '../../../models/CVDType.dart';
import '../../../models/simulationMode.dart';

class FilterButton extends StatelessWidget {
  final CVDType cvdType;
  final VoidCallback onTap;
  final bool isSelected;
  

  const FilterButton({
    super.key,
    required this.cvdType,
    required this.onTap,
    required this.isSelected,
    
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4DB6AC);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
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
              cvdType.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontFamily: 'DMSans'),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButtonRow extends StatelessWidget {
  final List<CVDType> cvdType;
  final CVDType selectedType;
  final CVDType selectedTypeBottom;
  final Function(CVDType) onTypeSelected;
  final Function(CVDType) onTypeSelectedBottom;
  final SimulationMode mode;

  const FilterButtonRow({
    super.key,
    required this.cvdType,
    required this.selectedType,
    required this.onTypeSelected,
    required this.selectedTypeBottom,
    required this.onTypeSelectedBottom,
    required this.mode
    });

    @override
  Widget build(BuildContext context) {
    
    if (mode == SimulationMode.single) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...cvdType.map((type) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: FilterButton(
              cvdType: type,
              onTap:() => onTypeSelected(type),
              isSelected: type == selectedType,
            ),
          );
        })
      ],
    );
  }
  

  return Column(
    children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...cvdType.map((type) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: FilterButton(
              cvdType: type,
              onTap:() => onTypeSelected(type),
              isSelected: type == selectedType,
            ),
          );
        })
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...cvdType.map((type) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: FilterButton(
              cvdType: type,
              onTap:() => onTypeSelectedBottom(type),
              isSelected: type == selectedTypeBottom,
            ),
          );
        })
      ],
    )
    ],
  );
}
}