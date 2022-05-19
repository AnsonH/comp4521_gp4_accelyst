import 'dart:io';

import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
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

  /// Deletes the roman room JSON file and the photos of that room.
  Future<void> deleteRoom() async {
    final json = await read();
    final romanRoom = RomanRoom.fromJson(json);

    // Delete saved photos
    for (RomanRoomItem item in romanRoom.items) {
      item.imageFile?.deleteSync();
    }

    final jsonFile = File(getFilePath);
    jsonFile.deleteSync();
  }
}
