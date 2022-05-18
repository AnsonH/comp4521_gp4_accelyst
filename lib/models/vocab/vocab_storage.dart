import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';

class VocabStorage extends StorageService {
  VocabStorage() {
    super.initialize(
      datapath: "vocab",
      filename: "vocabs.json",
    );
  }
}
