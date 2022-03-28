import 'package:comp4521_gp4_accelyst/models/photo_grid_item_data.dart';
import 'package:comp4521_gp4_accelyst/widgets/photo/photo_carousel.dart';
import 'package:comp4521_gp4_accelyst/widgets/photo/photo_grid_item.dart';
import 'package:flutter/material.dart';

/* References:
 *  - https://pub.dev/packages/photo_view#gallery
 *  - https://github.com/bluefireteam/photo_view/blob/master/example/lib/screens/examples/gallery/gallery_example.dart
 */

/// A grid photo gallery. Tapping on a grid item opens a photo carousel where users can zoom in or out.
/// Since this widget returns [SliverGrid], you should place this widget inside a [CustomScrollView]. For example:
/// ```dart
/// CustomScrollView(
///   slivers: [
///      /* ... */
///      const PhotoGrid(),
///   ],
/// ),
/// ```
///
/// External readings:
///  - [Using slivers to achieve fancy scrolling](https://docs.flutter.dev/development/ui/advanced/slivers)
///  - [Flutter Slivers Overview](https://youtu.be/k2v3gxtMlDE)
class PhotoGrid extends StatelessWidget {
  final List<PhotoGridItemData?> imagesData;
  final int childCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  /// Creates a grid photo gallery from [imagesData], which is a list of image files.
  ///
  /// [crossAxisCount] specifies the number of grid items per row, while [crossAxisSpacing] and [mainAxisSpacing]
  /// specifies the gap between each item on the same row and the gap between each row respectively.
  const PhotoGrid({
    Key? key,
    required this.imagesData,
    required this.childCount,
    this.crossAxisCount = 3,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      // Defines what widget should each child render
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return PhotoGridItem(
            itemData: imagesData[index],
            onTap: () {
              if (imagesData[index] != null) {
                _openCarousel(context, index);
              }
            },
          );
        },
        childCount: childCount,
      ),
      // Defines the grid layout
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
    );
  }

  void _openCarousel(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => PhotoCarousel(
          imagesData,
          initialIndex: index,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
