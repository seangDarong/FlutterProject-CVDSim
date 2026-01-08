import 'dart:io';

class StoredImage {
  final String id;
  final String filePath;
  final DateTime createdAt;

  const StoredImage({
    required this.id,
    required this.filePath,
    required this.createdAt,
  });
}


// class CapturedImage {
//   final String id;
//   final String imagePath;
//   final String cvdType;
//   final DateTime createdAt;

//   CapturedImage({
//     required this.id,
//     required this.imagePath,
//     required this.cvdType,
//     required this.createdAt,
//   });
// }
