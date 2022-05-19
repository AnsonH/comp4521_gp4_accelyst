import 'package:json_annotation/json_annotation.dart';

part 'mnemonics_data.g.dart';

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

  /// Searches a [MnemonicMaterial] instance by its UUID.
  ///
  /// For the return value (let's call it `result`):
  ///  - `result[0]` - Index in [subjectMaterials] array
  ///  - `result[1]` - Index in `materials` array of the nested [SubjectMaterialsData] instance.
  List<int> searchMaterialByUUID(String uuid) {
    int sIndex = 0;
    int mIndex = 0;

    for (; sIndex < subjectMaterials.length; ++sIndex) {
      final sMaterial = subjectMaterials[sIndex];
      mIndex = sMaterial.materials.indexWhere((e) => e.uuid == uuid);

      // Found the material with matching UUID
      if (mIndex != -1) {
        break;
      }
    }

    return [sIndex, mIndex];
  }

  /// Appends a material into [subjectMaterials].
  ///
  /// [materialLoc] is the index where [material] will be inserted to the `materials`
  /// array of the matching subject's [SubjectMaterialsData] instance.
  void appendNewMnemonic({
    required String subject,
    required MnemonicMaterial material,
    int? materialLoc,
  }) {
    // Insert to existing subject if exists
    final sIndex = subjectMaterials.indexWhere((element) {
      return element.subjectName == subject;
    });
    if (sIndex == -1) {
      // Create a new subject
      subjectMaterials.add(SubjectMaterialsData(
        subjectName: subject,
        materials: [material],
      ));
    } else {
      // Append data into existing subject
      if (materialLoc == null) {
        subjectMaterials[sIndex].materials.add(material);
      } else {
        subjectMaterials[sIndex].materials.insert(materialLoc, material);
      }
    }
  }

  /// A function to handle data changes to a [MnemonicMaterial] instance.
  void updateMaterial({
    required String uuid,
    required String newSubject,
    required String newTitle,
  }) {
    final searchResults = searchMaterialByUUID(uuid);
    int sIndex = searchResults[0];
    int mIndex = searchResults[1];

    // Delete the existing material object
    final MnemonicMaterial material = deleteMaterial(uuid);

    // Update the material title
    material.title = newTitle;

    // Append the updated material back to the appropriate location
    final bool becomesEmptySubject = subjectMaterials[sIndex].materials.isEmpty;
    appendNewMnemonic(
      subject: newSubject,
      material: material,
      materialLoc: becomesEmptySubject ? null : mIndex,
    );
  }

  /// Deletes a study material from a subject.
  ///
  /// It returns the deleted study material.
  MnemonicMaterial deleteMaterial(String uuid) {
    final searchResults = searchMaterialByUUID(uuid);
    int sIndex = searchResults[0];
    int mIndex = searchResults[1];

    final material = subjectMaterials[sIndex].materials.removeAt(mIndex);
    final bool becomesEmptySubject = subjectMaterials[sIndex].materials.isEmpty;
    if (becomesEmptySubject) {
      // Delete the subject if it has no study materials
      subjectMaterials.removeAt(sIndex);
    }

    return material;
  }

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
