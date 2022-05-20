import 'package:json_annotation/json_annotation.dart';

part 'vocab.g.dart';

@JsonSerializable()
class VocabSegment {
  String segment;
  String word;

  get getSegment {
    return segment;
  }

  set setSegment(String newSegment) {
    segment = newSegment;
  }

  get getWord {
    return word;
  }

  set setWord(String newWord) {
    word = newWord;
  }

  VocabSegment({required this.segment, required this.word});

  factory VocabSegment.fromJson(Map<String, dynamic> json) =>
      _$VocabSegmentFromJson(json);

  Map<String, dynamic> toJson() => _$VocabSegmentToJson(this);
}

@JsonSerializable()
class Vocab {
  final String id;
  String word;
  String definition;
  String description;

  List<VocabSegment> vocabSegments;

  Vocab({
    required this.id,
    required this.word,
    required this.definition,
    required this.description,
    required this.vocabSegments,
  });

  factory Vocab.fromJson(Map<String, dynamic> json) => _$VocabFromJson(json);

  Map<String, dynamic> toJson() => _$VocabToJson(this);

  get getWord {
    return word;
  }

  set setWord(String newWord) {
    word = newWord;
  }

  get getDefinition {
    return definition;
  }

  set setDefinition(String newDefinition) {
    definition = newDefinition;
  }

  get getDescription {
    return description;
  }

  set setDescription(String newDescription) {
    description = newDescription;
  }

  get getVocabSegments {
    return vocabSegments;
  }

  set setVocabSegments(List<VocabSegment> newVocabSegments) {
    vocabSegments = newVocabSegments;
  }

  get getStoryAudioPath {
    return "audio/" + id + ".mp3";
  }
}
