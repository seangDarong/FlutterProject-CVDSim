import '../utils/cvd_filters.dart';
import '../models/CVDType.dart';

final List<CVDType> cvdTypeData = [
  CVDType(
    id: 'normal',
    name: 'Normal',
    description: 'Normal color vision with no color blindness.',
    matrix: CVDFilters.normal,
    prevalence: '~92%',
    affected: '~7.4 billion',
  ),
  CVDType(
    id: 'protanopia',
    name: 'Protanopia',
    description:
        'Red-blindness caused by missing L-cones. Reds appear dark or black, and orange/green may look yellow.',
    matrix: CVDFilters.protanopia,
    prevalence: '~1.3%',
    affected: '~100 million',
  ),
  CVDType(
    id: 'deuteranopia',
    name: 'Deuteranopia',
    description:
        'Green-blindness caused by missing M-cones. Greens look beige/brown, and reds may appear brownish-yellow.',
    matrix: CVDFilters.deuteranopia,
    prevalence: '~1.2%',
    affected: '~95 million',
  ),
  CVDType(
    id: 'tritanopia',
    name: 'Tritanopia',
    description:
        'Blue-yellow color blindness caused by missing S-cones. Blues appear greenish and yellows appear violet or gray.',
    matrix: CVDFilters.tritanopia,
    prevalence: '~0.01%',
    affected: '~800,000',
  ),
];
