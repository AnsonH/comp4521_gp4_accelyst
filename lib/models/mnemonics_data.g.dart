// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mnemonics_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MnemonicsData _$MnemonicsDataFromJson(Map<String, dynamic> json) =>
    MnemonicsData(
      (json['subjectMaterials'] as List<dynamic>)
          .map((e) => SubjectMaterialsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MnemonicsDataToJson(MnemonicsData instance) =>
    <String, dynamic>{
      'subjectMaterials':
          instance.subjectMaterials.map((e) => e.toJson()).toList(),
    };

SubjectMaterialsData _$SubjectMaterialsDataFromJson(
        Map<String, dynamic> json) =>
    SubjectMaterialsData(
      subjectName: json['subjectName'] as String,
      materials: (json['materials'] as List<dynamic>)
          .map((e) => MnemonicMaterial.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectMaterialsDataToJson(
        SubjectMaterialsData instance) =>
    <String, dynamic>{
      'subjectName': instance.subjectName,
      'materials': instance.materials.map((e) => e.toJson()).toList(),
    };

MnemonicMaterial _$MnemonicMaterialFromJson(Map<String, dynamic> json) =>
    MnemonicMaterial(
      type: $enumDecode(_$MnemonicTypeEnumMap, json['type']),
      title: json['title'] as String,
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$MnemonicMaterialToJson(MnemonicMaterial instance) =>
    <String, dynamic>{
      'type': _$MnemonicTypeEnumMap[instance.type],
      'title': instance.title,
      'uuid': instance.uuid,
    };

const _$MnemonicTypeEnumMap = {
  MnemonicType.romanRoom: 'romanRoom',
  MnemonicType.vocabList: 'vocabList',
};
