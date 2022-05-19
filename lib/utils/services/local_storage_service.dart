import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// A base class for getting and storing data in the local storage. It can be used to
/// save user data in app local storage. This class will be inherited mainly in To-do,
/// Roman Room and Vocab for customized file and data management.
class StorageService {
  late String datapath;
  late String filename;
  static late Directory directory;

  String get getFilePath {
    return "${directory.path}/$datapath/$filename";
  }

  bool get isFilePathExist {
    final file = File(getFilePath);
    return file.existsSync();
  }

  /// It should be called in the constructor of any classes that extends from [StorageService].
  ///
  /// [callback] is called after the document directory is successfully obtained.
  Future<void> initialize({
    required String datapath,
    required String filename,
  }) async {
    this.datapath = datapath;
    this.filename = filename;
    directory = await getApplicationDocumentsDirectory();
    print("App Docs Directory: ${directory.path}");
  }

  /// This async function reads data from designated file and decodes the data.
  Future<Map<String, dynamic>> read([String path = ""]) async {
    if (path == "") {
      path = getFilePath;
    }
    final file = File(path);
    Map<String, dynamic> data = jsonDecode(await file.readAsString());
    return data;
  }

  /// This async function saves data to designated file.
  Future<void> save(String data, [String path = ""]) async {
    if (path == "") {
      path = getFilePath;
    }
    final file = File(path);

    // Create file if not exist
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    await file.writeAsString(data);
  }
}
