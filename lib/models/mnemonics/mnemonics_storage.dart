import 'dart:convert';

import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

class MnemonicsStorage extends StorageService {
  /// [callback] is called after initializing the storage service.
  MnemonicsStorage({void Function()? callback}) {
    super
        .initialize(
      datapath: "mnemonics",
      filename: "mnemonics.json",
    )
        .then((_) async {
      // Create the JSON file if not exist
      if (!isFilePathExist) {
        const initialData = MnemonicsData([]);
        // final initialData = MnemonicsData([
        //   SubjectMaterialsData(
        //     subjectName: "English",
        //     materials: [
        //       MnemonicMaterial(
        //         type: MnemonicType.vocabList,
        //         title: "Top 1000 Most Common English Vocabularies",
        //         uuid: const Uuid().v1(),
        //       ),
        //     ],
        //   ),
        //   SubjectMaterialsData(
        //     subjectName: "Chemistry",
        //     materials: [
        //       MnemonicMaterial(
        //         type: MnemonicType.romanRoom,
        //         title: "Periodic Table",
        //         uuid: const Uuid().v1(),
        //       ),
        //     ],
        //   ),
        // ]);
        String json = jsonEncode(initialData);
        await save(json);
      }

      if (callback != null) {
        callback();
      }
    });
  }

  /// Load data from the JSON file.
  Future<MnemonicsData> loadJsonData() async {
    final Map<String, dynamic> json = await read();
    return MnemonicsData.fromJson(json);
  }

  /// Save data into JSON file.
  Future<void> saveToJson(MnemonicsData data) async {
    final json = jsonEncode(data);
    await save(json);
  }
}
