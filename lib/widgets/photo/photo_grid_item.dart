import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/* References:
 *  - https://pub.dev/packages/photo_view#gallery
 *  - https://github.com/bluefireteam/photo_view/blob/master/example/lib/screens/examples/gallery/gallery_example_item.dart
 */

class PhotoGridItemData {
  final String id;
  final String resource;
  File? imageFile;

  PhotoGridItemData({
    required this.id,
    required this.resource,
  });
}

/// A single item in a photo grid.
class PhotoGridItem extends StatelessWidget {
  final PhotoGridItemData? itemData;
  final GestureTapCallback onTap;

  /// Creates a single item in a photo grid.
  ///
  /// Displays a loading spinner if [itemData] is null.
  const PhotoGridItem({
    Key? key,
    required this.itemData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemData == null
        ? Container(
            color: Colors.grey[300],
            child: const Center(
              child: SpinKitRing(
                color: Colors.grey,
                size: 40,
              ),
            ),
          )
        : GestureDetector(
            onTap: () => onTap(),
            child: Hero(
              tag: itemData!.id,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(itemData!.imageFile!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
  }
}
