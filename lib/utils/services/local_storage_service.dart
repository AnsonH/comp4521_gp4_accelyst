import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// This file stores code of a base class for getting and storing data in the local storage.
/// It can be used to save user data in app local storage.
/// This class will be inherited mainly in To-do, Roman Room and Vocab for customized file and data management.

class StorageService {
  late String datapath;
  late String filename;
  static late Directory directory;

  String get getFilePath {
    return "${directory.path}/${datapath}/${filename}";
  }

  Future<void> initialize() async {
    directory = await getApplicationDocumentsDirectory();
    print(directory.path);
  }

  /// This async function reads data from designated file and returns the data in a List.
  Future<List<dynamic>> _read() async {
    final file = File(getFilePath);
    List<dynamic> data = jsonDecode(await file.readAsString());
    return data;
  }

  /// This async function saves data to designated file.
  Future<void> _save(List data) async {
    final file = File(getFilePath);
    await file.writeAsString(await jsonEncode(data));
  }
}
