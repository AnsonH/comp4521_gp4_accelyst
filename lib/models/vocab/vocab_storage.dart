import 'dart:io';

import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';

class VocabStorage extends StorageService {
  VocabStorage(String filenameNoExt, {void Function()? callback}) {
    super
        .initialize(
      datapath: "vocab-list-data",
      filename: "$filenameNoExt.json",
    )
        .then((_) {
      if (callback != null) {
        callback();
      }
    });
  }

  /// Deletes the vocab list JSON file and the audio of such vocab.
  Future<void> deleteVocabList() async {
    final json = await read();
    final vocabList = VocabList.fromJson(json);

    // TODO: Delete all vocab audio
    for (Vocab vocab in vocabList.vocabs) {
      // vocab.imageFile?.deleteSync();
    }

    final jsonFile = File(getFilePath);
    jsonFile.deleteSync();
  }
}
