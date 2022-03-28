import 'dart:io';

/// Represents an item in a photo grid.
class PhotoGridItemData {
  final String id;

  /// Image URL if it has an online copy.
  String? url;

  /// Reference to the image stored in the file system.
  File? imageFile;

  PhotoGridItemData({
    required this.id,
    this.url,
    this.imageFile,
  });
}
