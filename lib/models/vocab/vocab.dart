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
}

class Vocab {
  final String id;
  String word;
  String definition;
  String description;

  List<VocabSegment> vocabSegments = [];

  Vocab(
      {required this.id,
      required this.word,
      required this.definition,
      required this.description});

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
