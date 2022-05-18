import 'dart:convert';

import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

class MnemonicsStorage extends StorageService {
  /// [callback] is called after initializing the storage service.
  MnemonicsStorage({required void Function() callback}) {
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
        //     subjectName: "History",
        //     materials: [
        //       MnemonicMaterial(
        //         type: MnemonicType.romanRoom,
        //         title: "World War 2 Timeline",
        //         uuid: const Uuid().v1(),
        //       ),
        //       MnemonicMaterial(
        //         type: MnemonicType.vocabList,
        //         title: "History vocab list",
        //         uuid: const Uuid().v1(),
        //       ),
        //     ],
        //   ),
        // ]);
        String json = jsonEncode(initialData);
        await save(json);
      }

      callback();
    });
  }

  /// Load data from the JSON file.
  Future<MnemonicsData> loadJsonData() async {
    final Map<String, dynamic> json = await read();
    return MnemonicsData.fromJson(json);
  }
}
