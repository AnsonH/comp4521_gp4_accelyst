import 'dart:io';
import 'package:comp4521_gp4_accelyst/models/photo_grid_item_data.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

/// Downloads an image from [imageUrl] and saves to a [File] instance.
///
/// If [imageName] (eg. `"foo.jpg"`) is not provided, it's extracted from [imageUrl].
///
/// Credits: https://www.kindacode.com/article/how-to-save-network-images-to-the-device-in-flutter/
Future<File> getImageFromUrl(
  String imageUrl, {
  String? imageName,
}) async {
  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode != 200) {
    throw HttpException('${response.statusCode}');
  }

  // Get the document directory path
  imageName ??= path.basename(imageUrl);
  final appDir = await path_provider.getApplicationDocumentsDirectory();
  final localPath = path.join(appDir.path, imageName);

  // Save to file
  final imageFile = File(localPath);
  await imageFile.writeAsBytes(response.bodyBytes);
  return imageFile;
}

/// Downloads image for each [PhotoGridItemData] instance in [data], then saves the file to `imageFile` property
/// of the [PhotoGridItemData] instance.
///
/// [saveSuccessCallback] is invoked after file is saved back to each element in [data].
void getImagesFromPhotoGridItemData({
  required List<PhotoGridItemData> data,
  required Function(int, PhotoGridItemData) saveSuccessCallback,
}) {
  for (int i = 0; i < data.length; ++i) {
    final url = data[i].url;
    if (url == null) {
      throw "`url` property of a `PhotoGridItemData` instance is null.";
    }

    getImageFromUrl(url, imageName: "${data[i].id}.jpg").then((image) {
      data[i].imageFile = image;
      saveSuccessCallback(i, data[i]);
    });
  }
}
