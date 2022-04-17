import 'dart:io';

/// Represents an item in a roman room.
class RomanRoomItem {
  /// UUID to identify the photo.
  final String id;

  /// Image URL if it has an online copy.
  String? url;

  /// Reference to the image stored in the file system.
  File? imageFile;

  RomanRoomItem({
    required this.id,
    this.url,
    this.imageFile,
  });
}
