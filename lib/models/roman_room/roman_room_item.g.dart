// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roman_room_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RomanRoomItem _$RomanRoomItemFromJson(Map<String, dynamic> json) =>
    RomanRoomItem(
      id: json['id'] as String,
      description: json['description'] as String?,
      imageFile:
          const FileJsonConverter().fromJson(json['imageFile'] as String),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$RomanRoomItemToJson(RomanRoomItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'imageFile': const FileJsonConverter().toJson(instance.imageFile),
      'url': instance.url,
    };
