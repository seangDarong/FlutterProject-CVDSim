import 'cvd_type.dart';

class ImageSession {
  final int index;
  final CVDType filter;
  final bool compare;

  const ImageSession({
    required this.index,
    required this.filter,
    required this.compare,
  });

  factory ImageSession.initial(int startIndex, CVDType normal) {
    return ImageSession(
      index: startIndex,
      filter: normal,
      compare: false,
    );
  }

  ImageSession copyWith({
    int? index,
    CVDType? filter,
    bool? compare,
  }) {
    return ImageSession(
      index: index ?? this.index,
      filter: filter ?? this.filter,
      compare: compare ?? this.compare,
    );
  }
}
