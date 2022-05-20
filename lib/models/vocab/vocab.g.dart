// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabSegment _$VocabSegmentFromJson(Map<String, dynamic> json) => VocabSegment(
      segment: json['segment'] as String,
      word: json['word'] as String,
    );

Map<String, dynamic> _$VocabSegmentToJson(VocabSegment instance) =>
    <String, dynamic>{
      'segment': instance.segment,
      'word': instance.word,
    };

Vocab _$VocabFromJson(Map<String, dynamic> json) => Vocab(
      id: json['id'] as String,
      word: json['word'] as String,
      definition: json['definition'] as String,
      description: json['description'] as String,
      vocabSegments: (json['vocabSegments'] as List<dynamic>)
          .map((e) => VocabSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VocabToJson(Vocab instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'definition': instance.definition,
      'description': instance.description,
      'vocabSegments': instance.vocabSegments.map((e) => e.toJson()).toList(),
    };
