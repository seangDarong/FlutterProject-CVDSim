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

  // /// Convenience: always access as File
  // File get file => File(filePath);

  // /// Equality by id (important later)
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is StoredImage && other.id == id;

  // @override
  // int get hashCode => id.hashCode;
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
