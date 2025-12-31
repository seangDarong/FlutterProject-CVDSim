import '../utils/cvd_filters.dart';
import '../models/CVDType.dart';

class CVDTypesData {
  static final List<CVDType> all = [
    CVDType(
      id: 'protanopia',
      name: 'Protanopia',
      description: 'Red-blindness caused by missing L-cones.',
      matrix: CVDFilters.protanopia,
    ),
    CVDType(
      id: 'deuteranopia',
      name: 'Deuteranopia',
      description: 'Green-blindness caused by missing M-cones.',
      matrix: CVDFilters.deuteranopia,
    ),
    CVDType(
      id: 'tritanopia',
      name: 'Tritanopia',
      description: 'Blue-yellow color blindness.',
      matrix: CVDFilters.tritanopia,
    ),
    CVDType(
      id: 'achromatopsia',
      name: 'Achromatopsia',
      description: 'Complete color blindness (grayscale vision).',
      matrix: CVDFilters.achromatopsia,
    ),
    CVDType(
      id: 'achromatomaly',
      name: 'Achromatomaly',
      description: 'Partial color blindness with reduced saturation.',
      matrix: CVDFilters.achromatomaly,
    ),
  ];

  static CVDType getById(String id) {
    return all.firstWhere((type) => type.id == id);
  }
}