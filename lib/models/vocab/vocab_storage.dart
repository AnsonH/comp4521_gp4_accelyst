import 'dart:io';

import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';

class VocabStorage extends StorageService {
  /// Constructor for Vocab Storage Service
  /// [filenameNoExt]
  /// [isAudio]: default value is false
  /// [callback]
  VocabStorage(String filenameNoExt,
      {void Function()? callback, bool isAudio = false}) {
    super
        .initialize(
      datapath: "vocab-list-data" + (isAudio ? "/audio" : ""),
      filename: "$filenameNoExt.${isAudio ? "m4a" : "json"}",
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
      if (File(StorageService.directory.path +
              "/" +
              datapath +
              "/audio/" +
              vocab.id +
              ".m4a")
          .existsSync()) {
        File(StorageService.directory.path +
                "/" +
                datapath +
                "/audio/" +
                vocab.id +
                ".m4a")
            .deleteSync();
      }
    }

    final jsonFile = File(getFilePath);
    jsonFile.deleteSync();
  }

  void deleteVocabAudio() {
    if (File(StorageService.directory.path + "/" + datapath + "/" + getFilePath)
        .existsSync()) {
      File(StorageService.directory.path + "/" + datapath + "/" + getFilePath)
          .deleteSync();
    }
  }
}
