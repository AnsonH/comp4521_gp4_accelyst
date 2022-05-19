// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roman_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RomanRoom _$RomanRoomFromJson(Map<String, dynamic> json) => RomanRoom(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => RomanRoomItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String? ?? "",
      subject: json['subject'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$RomanRoomToJson(RomanRoom instance) => <String, dynamic>{
      'id': instance.id,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'subject': instance.subject,
      'description': instance.description,
    };
