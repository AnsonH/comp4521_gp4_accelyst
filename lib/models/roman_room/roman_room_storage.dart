import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';

class RomanRoomStorage extends StorageService {
  RomanRoomStorage(String filenameNoExt) {
    super.initialize(
      datapath: "roman-room-data",
      filename: "$filenameNoExt.json",
    );
  }
}
