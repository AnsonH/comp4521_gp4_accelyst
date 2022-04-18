import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// A single item in a photo grid.
class PhotoGridItem extends StatelessWidget {
  final RomanRoomItem itemData;
  final int oldIndex;
  final GestureTapCallback onTap;
  final bool showImageThumbnail;

  /// Creates a single item in a photo grid.
  ///
  /// Displays a loading spinner if [itemData] is null.
  const PhotoGridItem({
    Key? key,
    required this.itemData,
    required this.oldIndex,
    required this.onTap,
    this.showImageThumbnail = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final indexString = (oldIndex + 1).toString();

    if (itemData.imageFile == null) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: SpinKitRing(
            color: Colors.grey,
            size: 40,
          ),
        ),
      );
    }

    return showImageThumbnail
        ? Material(
            child: Ink.image(
              image: FileImage(itemData.imageFile!),
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () => onTap(),
              ),
            ),
          )
        : ElevatedButton(
            child: Text(
              indexString,
              style: const TextStyle(fontSize: 40),
            ),
            onPressed: () => onTap(),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              onPrimary: Colors.grey[100],
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          );
  }
}
