import 'package:comp4521_gp4_accelyst/widgets/photo/photo_grid_item.dart';
import 'package:flutter/material.dart';

// Placeholder items
var gridItems = <PhotoGridItemData>[
  PhotoGridItemData(
    id: "item1",
    resource: "https://picsum.photos/id/237/1280/720",
  ),
  PhotoGridItemData(
    id: "item2",
    resource: "https://picsum.photos/id/236/1280/720",
  ),
  PhotoGridItemData(
    id: "item3",
    resource: "https://picsum.photos/id/235/1280/720",
  ),
  PhotoGridItemData(
    id: "item4",
    resource: "https://picsum.photos/id/234/1280/720",
  ),
  PhotoGridItemData(
    id: "item5",
    resource: "https://picsum.photos/id/233/1280/720",
  ),
  PhotoGridItemData(
    id: "item6",
    resource: "https://picsum.photos/id/232/1280/720",
  ),
  PhotoGridItemData(
    id: "item7",
    resource: "https://picsum.photos/id/231/1280/720",
  ),
  PhotoGridItemData(
    id: "item8",
    resource: "https://picsum.photos/id/230/1280/720",
  ),
  PhotoGridItemData(
    id: "item9",
    resource: "https://picsum.photos/id/237/1280/720",
  ),
  PhotoGridItemData(
    id: "item10",
    resource: "https://picsum.photos/id/236/1280/720",
  ),
  PhotoGridItemData(
    id: "item11",
    resource: "https://picsum.photos/id/235/1280/720",
  ),
  PhotoGridItemData(
    id: "item12",
    resource: "https://picsum.photos/id/234/1280/720",
  ),
];

class PhotoGrid extends StatelessWidget {
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  /// A grid photo gallery.
  ///
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
  const PhotoGrid({
    Key? key,
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
            itemData: gridItems[index],
            onTap: () {
              debugPrint("Pressed $index");
            },
          );
        },
        childCount: gridItems.length,
      ),
      // Defines the grid layout
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
    );
  }
}
