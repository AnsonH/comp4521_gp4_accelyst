import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// A button to let user add photos via camera or photo gallery.
class AddPhotoButton extends StatelessWidget {
  /// Callback to be called if user successfully picked a photo.
  final void Function(XFile image, String description) onSuccess;

  /// Creates an "Add a photo" button.
  ///
  /// [onSuccess] is called if user successfully picked a photo via camera or photo gallery.
  AddPhotoButton({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  final _picker = ImagePicker();
  final _descriptionController = TextEditingController();

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image == null) {
        return;
      }

      // Show dialog for entering the description of the photo.
      final String description = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Input object description"),
          content: TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: "Description of the object",
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null, // Take as much lines as the input value
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Remove keyboard focus from the text field
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context, _descriptionController.text);
              },
              child: const Text("DONE"),
            ),
          ],
        ),
      );

      onSuccess(image, description);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.add_photo_alternate,
            size: 40,
          ),
          Text(
            "Add a photo",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber[600],
        onPrimary: Colors.black,
        padding: const EdgeInsets.all(16),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Wrap(children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () async {
                  await _pickImage(ImageSource.camera, context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () async {
                  await _pickImage(ImageSource.gallery, context);
                  Navigator.pop(context);
                },
              ),
            ]),
          ),
        );
      },
    );
  }
}

final _errorSnackBar = SnackBar(
  content: const Text(
    "Something went wrong. Please try again!",
    style: TextStyle(fontSize: 15),
  ),
  backgroundColor: Colors.red[700],
  behavior: SnackBarBehavior.floating,
);
