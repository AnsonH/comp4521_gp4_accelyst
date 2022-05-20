import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import "package:comp4521_gp4_accelyst/utils/json_converter/file_json_converter.dart";

part "roman_room_item.g.dart";

/// Represents an item in a roman room.
@JsonSerializable()
@FileJsonConverter()
class RomanRoomItem {
  /// UUID to identify the photo.
  final String id;

  /// Description of the item.
  String? description;

  /// Reference to the image stored in the file system.
  File? imageFile;

  RomanRoomItem({
    required this.id,
    this.description,
    this.imageFile,
  });

  factory RomanRoomItem.fromJson(Map<String, dynamic> json) =>
      _$RomanRoomItemFromJson(json);

  Map<String, dynamic> toJson() => _$RomanRoomItemToJson(this);
}
