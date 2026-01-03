class CVDFilters {
  static const List<double> normal = [
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ];

  static const List<double> protanopia = [
    0.567, 0.433, 0.000, 0, 0,
    0.558, 0.442, 0.000, 0, 0,
    0.000, 0.242, 0.758, 0, 0,
    0,     0,     0,     1, 0,
  ];

  static const List<double> deuteranopia = [
    0.625, 0.375, 0.000, 0, 0,
    0.700, 0.300, 0.000, 0, 0,
    0.000, 0.300, 0.700, 0, 0,
    0,     0,     0,     1, 0,
  ];

  static const List<double> tritanopia = [
    0.950, 0.050, 0.000, 0, 0,
    0.000, 0.433, 0.567, 0, 0,
    0.000, 0.475, 0.525, 0, 0,
    0,     0,     0,     1, 0,
  ];

  //Not used
  // static const List<double> achromatopsia = [
  //   0.299, 0.587, 0.114, 0, 0,
  //   0.299, 0.587, 0.114, 0, 0,
  //   0.299, 0.587, 0.114, 0, 0,
  //   0,     0,     0,     1, 0,
  // ];
  
  // // Add the "Achromatomaly" you asked about too!
  // static const List<double> achromatomaly = [
  //   0.618, 0.320, 0.062, 0, 0,
  //   0.163, 0.775, 0.062, 0, 0,
  //   0.163, 0.320, 0.516, 0, 0,
  //   0,     0,     0,     1, 0,
  // ];
}