import '../utils/cvd_filters.dart';
import '../models/CVDType.dart';


  final List<CVDType> cvdTypeData= [
    CVDType(
      id: 'normal',
      name: 'normal',
      description: 'normal',
      matrix: CVDFilters.normal,
    ),
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
    
  ];

  
