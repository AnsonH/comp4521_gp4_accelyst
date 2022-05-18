import 'package:json_annotation/json_annotation.dart';

part "mnemonics_data.g.dart";

enum MnemonicType {
  @JsonValue("romanRoom")
  romanRoom,

  @JsonValue("vocabList")
  vocabList,
}

/// Represents different subjects and corresponding roman room or vocab lists
/// in the Mnemonics page.
@JsonSerializable()
class MnemonicsData {
  final List<SubjectMaterialsData> subjectMaterials;

  const MnemonicsData(this.subjectMaterials);

  factory MnemonicsData.fromJson(Map<String, dynamic> json) =>
      _$MnemonicsDataFromJson(json);

  Map<String, dynamic> toJson() => _$MnemonicsDataToJson(this);
}

/// Represents a single subject and its corresponding roman rooms or vocab lists.
@JsonSerializable()
class SubjectMaterialsData {
  String subjectName;
  final List<MnemonicMaterial> materials;

  SubjectMaterialsData({
    required this.subjectName,
    required this.materials,
  });

  factory SubjectMaterialsData.fromJson(Map<String, dynamic> json) =>
      _$SubjectMaterialsDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectMaterialsDataToJson(this);
}

/// Represents data of a single tile in the Mnemonics main page.
@JsonSerializable()
class MnemonicMaterial {
  final MnemonicType type;

  /// Title of the material.
  String title;

  /// UUID to be used to name the JSON file that stores the roman room / vocab list data.
  String uuid;

  MnemonicMaterial({
    required this.type,
    required this.title,
    required this.uuid,
  });

  factory MnemonicMaterial.fromJson(Map<String, dynamic> json) =>
      _$MnemonicMaterialFromJson(json);

  Map<String, dynamic> toJson() => _$MnemonicMaterialToJson(this);
}
