import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:json_annotation/json_annotation.dart';

part "roman_room.g.dart";

/// Represents a roman room.
@JsonSerializable()
class RomanRoom {
  final String id;
  List<RomanRoomItem> items;
  String name;
  String subject;
  String description;

  RomanRoom({
    required this.id,
    required this.items,
    this.name = "",
    this.subject = "",
    this.description = "",
  });

  /// Searches a roman room item in the [items] list by its ID and returns its index in the list.
  ///
  /// Returns -1 if not found.
  int getItemIndex(String itemId) {
    return items.indexWhere((element) => element.id == itemId);
  }

  factory RomanRoom.fromJson(Map<String, dynamic> json) =>
      _$RomanRoomFromJson(json);

  Map<String, dynamic> toJson() => _$RomanRoomToJson(this);
}
