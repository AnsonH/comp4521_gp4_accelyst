import 'dart:io';

import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';
import 'package:flutter/services.dart';

Future<void> initSampleFiles() async {
  final ss = StorageService();
  // Check mnemonics
  await ss.initialize(datapath: "mnemonics", filename: "mnemonics.json");
  String path = StorageService.directory.path;
  if (!ss.isFilePathExist) {
    // TODO: import mnemonics.json to ~/mnemonics/
    copyFile(
        oldPath: "assets/samples/mnemonics.json",
        newPath: "$path/mnemonics/mnemonics.json");
  }
  // Check roman room
  ss.datapath = "roman-room-data";
  ss.filename = "f84325f0-d792-11ec-a0e4-6d428c57a67e.json";
  if (!ss.isFilePathExist) {
    // TODO: import roman room files to ~/roman-room-data/
    // Roman room JSON
    copyFile(
        oldPath:
            "assets/samples/romanroom/f84325f0-d792-11ec-a0e4-6d428c57a67e.json",
        newPath:
            "$path/roman-room-data/f84325f0-d792-11ec-a0e4-6d428c57a67e.json");
    // Roman room pic 1
    copyFile(
        oldPath: "assets/samples/romanroom/image_picker2558513802704829566.jpg",
        newPath:
            "$path/roman-room-data/img/image_picker2558513802704829566.jpg");
    // Roman room pic 2
    copyFile(
        oldPath: "assets/samples/romanroom/image_picker5041454899599093914.jpg",
        newPath:
            "$path/roman-room-data/img/image_picker5041454899599093914.jpg");
  }
  // Check vocab list
  ss.datapath = "vocab-list-data";
  ss.filename = "74230f80-d790-11ec-8f19-fd5579bc56a7.json";
  if (!ss.isFilePathExist) {
    // TODO: import vocab list files to ~/vocab-list-data/
    // Vocab list JSON
    copyFile(
        oldPath:
            "assets/samples/vocablist/74230f80-d790-11ec-8f19-fd5579bc56a7.json",
        newPath:
            "$path/vocab-list-data/74230f80-d790-11ec-8f19-fd5579bc56a7.json");
    // Vocab 1 audio
    copyFile(
        oldPath:
            "assets/samples/vocablist/10f8bfd0-d791-11ec-bfda-6f30d458013e.mp3",
        newPath:
            "$path/vocab-list-data/audio/10f8bfd0-d791-11ec-bfda-6f30d458013e.mp3");
    // Vocab 2 audio
    copyFile(
        oldPath:
            "assets/samples/vocablist/72e283c0-d791-11ec-ac24-8747ed2bcf31.mp3",
        newPath:
            "$path/vocab-list-data/audio/72e283c0-d791-11ec-ac24-8747ed2bcf31.mp3");
  }
}

Future<void> copyFile(
    {required String oldPath, required String newPath}) async {
  ByteData data = await rootBundle.load(oldPath);
  final buffer = data.buffer;
  File(newPath).createSync(recursive: true);
  File(newPath).writeAsBytesSync(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
