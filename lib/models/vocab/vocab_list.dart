import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vocab_list.g.dart';

@JsonSerializable()
class VocabList {
  final String id;
  String name;
  String subject;
  String description;
  List<Vocab> vocabs;

  VocabList({
    required this.id,
    required this.name,
    required this.subject,
    required this.description,
    required this.vocabs,
  });

  factory VocabList.fromJson(Map<String, dynamic> json) =>
      _$VocabListFromJson(json);

  Map<String, dynamic> toJson() => _$VocabListToJson(this);
}
