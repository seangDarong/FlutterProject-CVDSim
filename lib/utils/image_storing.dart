import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../models/captured_image.dart';
import 'package:uuid/uuid.dart';

class ImageStoring {
  static const _uuid = Uuid();

  /// Base directory: iOS app Documents
  static Future<Directory> _imagesDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(dir.path, 'images'));

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    return imagesDir;
  }

  /// Save image bytes to app storage
  static Future<CapturedImage> saveImage(Uint8List bytes) async {
    final dir = await _imagesDir();
    final id = _uuid.v4();
    final filePath = p.join(dir.path, '$id.jpg');

    final file = File(filePath);
    await file.writeAsBytes(bytes);

    return CapturedImage(
      id: id,
      imagePath: filePath,
      cvdType: 'none',
      createdAt: DateTime.now(),
    );
  }

  /// Load all saved images
  static Future<List<CapturedImage>> loadImages() async {
    final dir = await _imagesDir();
    final files = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.jpg'))
        .toList();

    return files.map((file) {
      final id = p.basenameWithoutExtension(file.path);
      return CapturedImage(
        id: id,
        imagePath: file.path,
        cvdType: 'none',
        createdAt: file.lastModifiedSync(),
      );
    }).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Delete image
  static Future<void> deleteImage(CapturedImage image) async {
    final file = File(image.imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
