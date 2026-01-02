import 'package:flutter/material.dart';
import '../../../models/CVDType.dart';

class FilterInfoCard extends StatelessWidget {
  final CVDType cvdType;

  const FilterInfoCard({super.key, required this.cvdType});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 348,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                cvdType.name,
                style: const TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                cvdType.description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: 'DMSans',
                ),
              ),
              const SizedBox(height: 8),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prevalence: ${cvdType.prevalence}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: 'DMSans',
                    ),
                  ),
                  Text(
                    'Affected: ${cvdType.affected}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: 'DMSans',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
