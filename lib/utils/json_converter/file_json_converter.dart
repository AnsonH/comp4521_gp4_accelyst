import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

/// Serializes a nullable [File] object into String so that its data can be stored in a JSON file.
///
/// We simply store the path of the [File] object in the JSON file.
class FileJsonConverter implements JsonConverter<File?, String> {
  const FileJsonConverter();

  @override
  File? fromJson(String json) {
    return json == "null" ? null : File(json);
  }

  @override
  String toJson(File? file) {
    return file == null ? "null" : file.path;
  }
}
