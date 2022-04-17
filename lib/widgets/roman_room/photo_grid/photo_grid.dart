import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/add_photo_button.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_carousel.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
///      PhotoGrid(/* ... */),
///   ],
/// ),
/// ```
///
/// External readings:
///  - [Using slivers to achieve fancy scrolling](https://docs.flutter.dev/development/ui/advanced/slivers)
///  - [Flutter Slivers Overview](https://youtu.be/k2v3gxtMlDE)
class PhotoGrid extends StatelessWidget {
  /// List of image data stored in [RomanRoomItem] model class.
  final List<RomanRoomItem?> imagesData;

  /// Number of images
  final int imageCount;

  /// Number of grid items per row
  final int crossAxisCount;

  /// Vertical gap between each row of grid items.
  final double crossAxisSpacing;

  /// Horizontal gap between each grid item within a row.
  final double mainAxisSpacing;

  /// Whether to show an "Add a photo" button at the last.
  ///
  /// You should supply [onAddPhotoSuccess] if this is set to true.
  final bool showAddPhotoButton;

  /// Optional callback for successfully adding a photo.
  ///
  /// This is optional when [showAddPhotoButton] is false.
  final void Function(XFile)? onAddPhotoSuccess;

  /// Optional callback for deleting a photo from the grid.
  final void Function(String id)? onDeletePhoto;

  /// Creates a grid photo gallery, where tapping an item opens a photo carousel.
  const PhotoGrid({
    Key? key,
    required this.imagesData,
    required this.imageCount,
    this.crossAxisCount = 3,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
    this.showAddPhotoButton = false,
    this.onAddPhotoSuccess,
    this.onDeletePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      // Defines what widget should each child render
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return (showAddPhotoButton && index == imageCount)
              ? AddPhotoButton(onSuccess: onAddPhotoSuccess ?? (image) {})
              : PhotoGridItem(
                  itemData: imagesData[index],
                  onTap: () {
                    if (imagesData[index] != null) {
                      _openCarousel(context, index);
                    }
                  },
                );
        },
        childCount: imageCount + (showAddPhotoButton ? 1 : 0),
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
          onDeletePhoto: onDeletePhoto,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
