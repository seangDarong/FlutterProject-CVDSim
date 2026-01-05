import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/stored_image.dart';

class ImageStoring {
  static const _uuid = Uuid();

  // directory != filepath (str) altho the same but directory more powerful
  // Directory ≠ file path (String).
  // A file path is just text.
  // A Directory wraps a path and provides filesystem operations (exists, create, list, etc.).

  /// Base directory: iOS app Documents/images
  // Gets the app’s Documents directory, ensures an `images` subfolder exists,
  // and returns a Directory reference to it.
  static Future<Directory> _imagesDir() async {
    final dir = await getApplicationDocumentsDirectory(); //finds the app's document dir
    final imagesDir = Directory(p.join(dir.path, 'images')); //creates a dir obj that points to images dir in doc dir

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    } //does not create the images dir if it alr exists

    return imagesDir; //return the dir for use
  }

  /// Save image bytes to app storage
  static Future<StoredImage> saveImage(Uint8List bytes) async {
    final dir = await _imagesDir(); //images dir for use
    final id = _uuid.v4(); //for naming image
    final filePath = p.join(dir.path, '$id.jpg'); //filepath for saving image later (str)

    final file = File(filePath); //creates file obj that points to the file like the directory thing on top doesnt actually create the thing itself yet tho
    await file.writeAsBytes(bytes); //creates the file and fill it with the bytes from parameter that is the image from the camera we took 

    return StoredImage(
      id: id,
      filePath: filePath,
      createdAt: DateTime.now(),
    ); //returning for use later 
  }

  /// Load all saved images
  static Future<List<StoredImage>> loadImages() async {
    final dir = await _imagesDir(); //dir obj for images dir

    final files = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.jpg'))
        .toList(); //this one's a bit dense but imma try my best 
        //returns everything in said dir, then where the type of file is a File obj?, then where said File obj ends with a .jpg, then finally converts them to a list of File objs
        //Lists all items in the images directory, keeps only files, filters for .jpg files, and converts the result into a List<File>.

    final images = files.map((file) {
      final id = p.basenameWithoutExtension(file.path);
      return StoredImage(
        id: id,
        filePath: file.path,
        createdAt: file.lastModifiedSync(),
      );
    }).toList();
    //also dense AF
    //do map on the list of files obj we just did on top, then make the var id to the name of the File obj without .jpg, then return stored image with the id just now, filepath, and file date, another to list but this time a storedimage list 
    //Convert each image file into a StoredImage by extracting its ID, path, and timestamp.

    images.sort((a, b) => b.createdAt.compareTo(a.createdAt)); //sort from new to old 
    return images; //returns a list of stored images with sorted dates
  }

  /// Delete image from disk
  static Future<void> deleteImage(StoredImage image) async {
    final file = File(image.filePath); //file obj from the provided image parameter that is pointing to where it is
    if (await file.exists()) { //if exists bye bye
      await file.delete();
    }
  }
}
