import 'package:flutter/material.dart';

/* References:
 *  - https://pub.dev/packages/photo_view#gallery
 *  - https://github.com/bluefireteam/photo_view/blob/master/example/lib/screens/examples/gallery/gallery_example_item.dart
 */

class PhotoGridItemData {
  PhotoGridItemData({
    required this.id,
    required this.resource,
  });

  final String id;
  final String resource;
}

class PhotoGridItem extends StatelessWidget {
  final PhotoGridItemData itemData;
  final GestureTapCallback onTap;

  const PhotoGridItem({
    Key? key,
    required this.itemData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Hero(
        tag: itemData.id,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(itemData.resource),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
