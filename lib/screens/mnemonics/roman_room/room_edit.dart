import 'dart:convert';
import 'dart:io';

import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_storage.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_storage.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/add_photo_button.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_grid.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/reorder_snackbar.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/save_successful_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RoomEdit extends StatefulWidget {
  /// True if we're creating a new room. False if we're editing an existing room.
  final bool isNewRoom;

  const RoomEdit({
    Key? key,
    this.isNewRoom = false,
  }) : super(key: key);

  @override
  State<RoomEdit> createState() => _RoomEditState();
}

class _RoomEditState extends State<RoomEdit> {
  // Form related states
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  late final RomanRoom roomData;

  /// Whether users can reorder the room object grid items.
  bool allowReorder = false;

  Future<void> _initializeRoomData() async {
    if (widget.isNewRoom) {
      roomData = RomanRoom(
        id: const Uuid().v1(),
        items: [],
      );
    } else {
      // TODO: Load room data from storage service
    }
  }

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

  void _saveRomanRoom(BuildContext context) {
    // Validate form
    if (_formKey.currentState!.validate()) {
      // Encode `roomData` to JSON
      final String json = jsonEncode(roomData);
      debugPrint(json);

      // Save room data to local storage
      final storageService = RomanRoomStorage(roomData.id);
      storageService.save(json);

      // Append room into MnemonicsData
      late final MnemonicsStorage mnemonicsStorage;
      mnemonicsStorage = MnemonicsStorage(callback: () {
        mnemonicsStorage.loadJsonData().then((mnemonicsData) {
          // Append this roman room to the mnemonicsData
          mnemonicsData.appendNewMnemonic(
            subject: roomData.subject,
            material: MnemonicMaterial(
              type: MnemonicType.romanRoom,
              title: roomData.name,
              uuid: roomData.id,
            ),
          );

          // Update actual mnemonics.json
          final String updatedJson = jsonEncode(mnemonicsData);
          mnemonicsStorage.save(updatedJson);
          showSaveSuccessfulSnackbar(context);

          if (widget.isNewRoom) {
            // Go back to Mnemonics home page
            Navigator.pop(context);
          }
        });
      });
    }
  }

  void _addTextControllerListeners() {
    _nameController.addListener(() {
      setState(() => roomData.name = _nameController.text);
    });
    _subjectController.addListener(() {
      setState(() => roomData.subject = _subjectController.text);
    });
    _descriptionController.addListener(() {
      setState(() => roomData.description = _descriptionController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeRoomData();
    _addTextControllerListeners();
  }

  /* TODO for room edit:
   * 1. Create a model class to represent form data
   * 2. Validate the form on save
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNewRoom ? "New Roman Room" : "Edit Roman Room"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name*"),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? "Required field"
                      : null;
                },
              ),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: "Subject*"),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? "Required field"
                      : null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
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
                          showReorderSnackbar(context);
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
              roomData.items.isEmpty
                  ? Expanded(child: Container())
                  : Container(),
              // "Save" button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: ElevatedButton.icon(
                  onPressed: () => _saveRomanRoom(context),
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
  }
}
