import 'dart:io';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/add_photo_button.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_grid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RoomEdit extends StatefulWidget {
  const RoomEdit({Key? key}) : super(key: key);

  @override
  State<RoomEdit> createState() => _RoomEditState();
}

class _RoomEditState extends State<RoomEdit> {
  final _formKey = GlobalKey<FormState>();

  /// Whether users can reorder the room object grid items.
  bool allowReorder = false;

  // TODO: Load room data from storage service
  final roomData = RomanRoom(
    id: "foo",
    items: [],
  );

  void _addImage(XFile image, String description, BuildContext context) {
    // TODO: Save the image to a persistent, non-cache folder
    // Image is saved to `/data/data/com.example.comp4521_gp4_accelyst/cache`
    // Use "Device File Explorer" to view local files: https://developer.android.com/studio/debug/device-file-explorer
    final newRoomItem = RomanRoomItem(
      id: const Uuid().v4(),
      imageFile: File(image.path),
      description: description,
    );

    setState(() {
      roomData.items.add(newRoomItem);
    });
  }

  void _deleteImage(String id) {
    final imageToRemove = roomData.items.firstWhere((item) => item.id == id);

    // image_picker always saves images to this app's cache folder. Hence, removing an image chosen from
    // image gallery will only delete the one from the cache folder, not the original copy in the image gallery.
    imageToRemove.imageFile?.delete();

    setState(() {
      roomData.items.removeWhere((image) => image.id == id);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final element = roomData.items.removeAt(oldIndex);
      roomData.items.insert(newIndex, element);
    });
  }

  /* TODO for room edit:
   * 1. Create a model class to represent form data
   * 2. Validate the form on save
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Roman Room"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(height: 5),
              TextFormField(
                decoration: const InputDecoration(labelText: "Subject"),
              ),
              const SizedBox(height: 5),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                keyboardType: TextInputType.multiline,
                maxLines: null, // Take as much lines as the input value
              ),
              SizedBox(
                height: roomData.items.length >= 2 ? 10 : 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Room Objects",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  // Reorder button
                  if (roomData.items.length >= 2)
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() => allowReorder = !allowReorder);

                        if (allowReorder) {
                          _showReorderSnackbar(context);
                        }
                      },
                      icon: Icon(
                        allowReorder ? Icons.done : Icons.import_export,
                        size: 22,
                      ),
                      label: Text(allowReorder ? "Finish Reorder" : "Reorder"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
                        primary: allowReorder ? Colors.green[800] : null,
                        side: BorderSide(
                          color:
                              allowReorder ? Colors.green[800]! : primaryColor!,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              roomData.items.isEmpty
                  ? AddPhotoButton(
                      onSuccess: (image, description) {
                        _addImage(image, description, context);
                      },
                    )
                  : Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: PhotoGrid(
                            roomData: roomData,
                            itemsData: roomData.items,
                            // Hide the "Add Photo" button if user pressed "Reorder" button
                            // Otherwise, users can reorder the "Add Photo" button and cause bugs
                            showAddPhotoButton: !allowReorder,
                            onAddPhotoSuccess: (image, description) {
                              _addImage(image, description, context);
                            },
                            onDeletePhoto: _deleteImage,
                            allowReorder: allowReorder,
                            onReorder: _onReorder,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showReorderSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text("Hold and drag a room object to reorder."),
      action: SnackBarAction(
        label: "OK",
        textColor: secondaryColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
