// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabList _$VocabListFromJson(Map<String, dynamic> json) => VocabList(
      id: json['id'] as String,
      name: json['name'] as String,
      subject: json['subject'] as String,
      description: json['description'] as String,
      vocabs: (json['vocabs'] as List<dynamic>)
          .map((e) => Vocab.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VocabListToJson(VocabList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'description': instance.description,
      'vocabs': instance.vocabs.map((e) => e.toJson()).toList(),
    };
