import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';

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
}
