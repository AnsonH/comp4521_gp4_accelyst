import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';

class RomanRoomStorage extends StorageService {
  RomanRoomStorage(String filenameNoExt, {void Function()? callback}) {
    super
        .initialize(
      datapath: "roman-room-data",
      filename: "$filenameNoExt.json",
    )
        .then((_) {
      if (callback != null) {
        callback();
      }
    });
  }
}
