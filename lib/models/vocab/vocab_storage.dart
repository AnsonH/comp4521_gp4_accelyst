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
}
