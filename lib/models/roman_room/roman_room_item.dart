import 'dart:io';

/// Represents an item in a roman room.
class RomanRoomItem {
  /// UUID to identify the photo.
  final String id;

  /// Description of the item.
  String? description;

  /// Reference to the image stored in the file system.
  File? imageFile;

  /// Image URL if it has an online copy.
  String? url;

  RomanRoomItem({
    required this.id,
    this.description,
    this.imageFile,
    this.url,
  });
}
