import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/add_photo_button.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:uuid/uuid.dart';

/// A grid photo gallery for roman room items.
class PhotoGrid extends StatelessWidget {
  /// Data of entire roman room.
  final RomanRoom roomData;

  /// List of image data to be rendered.
  ///
  /// It does not necessarily has to equal to `roomData.items` since users can shuffle
  /// items in the grid during revision mode.
  final List<RomanRoomItem> itemsData;

  /// Number of images
  final int itemCount;

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

  /// Whether grid items can be dragged to reorder.
  final bool allowReorder;

  /// Optional callback to be called after releasing a dragged child.
  ///
  /// [allowReorder] has to be true so that it can be called.
  final void Function(int, int)? onReorder;

  /// If false, each tile becomes a greyed box with a number.
  final bool showImageThumbnail;

  /// Creates a grid photo gallery, where tapping an item opens a photo carousel.
  const PhotoGrid({
    Key? key,
    required this.roomData,
    required this.itemsData,
    required this.itemCount,
    this.showAddPhotoButton = false,
    this.onAddPhotoSuccess,
    this.onDeletePhoto,
    this.allowReorder = false,
    this.onReorder,
    this.showImageThumbnail = true,
  }) : super(key: key);

  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  );

  @override
  Widget build(BuildContext context) {
    int totalItemCount = itemCount + (showAddPhotoButton ? 1 : 0);

    Widget itemBuilder(BuildContext context, int index) {
      final RomanRoomItem roomItem = itemsData[index];
      final int oldIndex = roomData.getItemIndex(roomItem.id);

      return (showAddPhotoButton && index == itemCount)
          ? AddPhotoButton(
              key: const ValueKey("add-photo"),
              onSuccess: onAddPhotoSuccess ?? (image) {},
            )
          : PhotoGridItem(
              key: ValueKey(const Uuid().v4()),
              oldIndex: oldIndex,
              itemData: roomItem,
              showImageThumbnail: showImageThumbnail,
              onTap: () => _openItemDialog(context, oldIndex, roomItem),
            );
    }

    return allowReorder
        ? ReorderableGridView.builder(
            shrinkWrap: true,
            onReorder: onReorder ?? (oldIndex, newIndex) {},
            itemCount: totalItemCount,
            itemBuilder: itemBuilder,
            gridDelegate: gridDelegate,
            physics: const ScrollPhysics(),
          )
        : GridView.builder(
            shrinkWrap: true,
            itemCount: totalItemCount,
            itemBuilder: itemBuilder,
            gridDelegate: gridDelegate,
            physics: const ScrollPhysics(),
          );
  }
}

void _openItemDialog(
  BuildContext context,
  int oldIndex,
  RomanRoomItem roomItem,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Item ${oldIndex + 1}",
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(roomItem.imageFile!),
          if (roomItem.description != null) const SizedBox(height: 20),
          if (roomItem.description != null) Text(roomItem.description!),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}
