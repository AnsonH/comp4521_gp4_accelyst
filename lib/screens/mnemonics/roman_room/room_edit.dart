import 'dart:io';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
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

  // TODO: Unfinished
  final roomData = RomanRoom(
    id: "foo",
    items: [],
  );

  final List<RomanRoomItem> _images = [];

  void _addImage(XFile image) {
    // Image is saved to `/data/data/com.example.comp4521_gp4_accelyst/cache`
    // Use "Device File Explorer" to view local files: https://developer.android.com/studio/debug/device-file-explorer
    setState(() {
      _images.add(RomanRoomItem(
        id: const Uuid().v4(),
        imageFile: File(image.path),
      ));
    });
  }

  void _deleteImage(String id) {
    final imageToRemove = _images.firstWhere((item) => item.id == id);

    // image_picker always saves images to this app's cache folder. Hence, removing an image chosen from
    // image gallery will only delete the one from the cache folder, not the original copy in the image gallery.
    imageToRemove.imageFile?.delete();

    setState(() {
      _images.removeWhere((image) => image.id == id);
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
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            // Using slivers allow us to scroll the list and grid views together
            // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Name"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Subject"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Description"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null, // Take as much lines as the input value
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Your Roman Room",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Hide the large "Add a photo" button if there are existing photos
                    _images.isEmpty
                        ? AddPhotoButton(onSuccess: _addImage)
                        : Container(),
                  ],
                ),
              ),
              // Show photo grid if there are existing photos
              _images.isEmpty
                  ? SliverList(
                      delegate: SliverChildListDelegate([]),
                    )
                  : PhotoGrid(
                      roomData: roomData,
                      itemsData: _images,
                      itemCount: _images.length,
                      showAddPhotoButton: true,
                      onAddPhotoSuccess: _addImage,
                      onDeletePhoto: _deleteImage,
                    ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 30),
                  Text(
                    "Room Objects",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
