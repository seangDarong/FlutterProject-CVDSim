import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/stored_image.dart';

class ImageStoring {
  static const _uuid = Uuid();

  /// Base directory: iOS app Documents/images
  static Future<Directory> _imagesDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(dir.path, 'images'));

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    return imagesDir;
  }

  /// Save image bytes to app storage
  static Future<StoredImage> saveImage(Uint8List bytes) async {
    final dir = await _imagesDir();
    final id = _uuid.v4();
    final filePath = p.join(dir.path, '$id.jpg');

    final file = File(filePath);
    await file.writeAsBytes(bytes);

    return StoredImage(
      id: id,
      filePath: filePath,
      createdAt: DateTime.now(),
    );
  }

  /// Load all saved images
  static Future<List<StoredImage>> loadImages() async {
    final dir = await _imagesDir();

    final files = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.jpg'))
        .toList();

    final images = files.map((file) {
      final id = p.basenameWithoutExtension(file.path);
      return StoredImage(
        id: id,
        filePath: file.path,
        createdAt: file.lastModifiedSync(),
      );
    }).toList();

    images.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return images;
  }

  /// Delete image from disk
  static Future<void> deleteImage(StoredImage image) async {
    final file = File(image.filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
