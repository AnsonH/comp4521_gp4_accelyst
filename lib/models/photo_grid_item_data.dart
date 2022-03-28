import 'dart:io';

/// Represents an item in a photo grid.
class PhotoGridItemData {
  final String id;
  String? url;
  File? imageFile; // Image will be stored in file system

  PhotoGridItemData({
    required this.id,
    this.url,
    this.imageFile,
  });
}
