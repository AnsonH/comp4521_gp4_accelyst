import 'package:flutter/material.dart';

/// A button to let user add photos via camera or photo gallery.
class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({
    Key? key,
  }) : super(key: key);

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
            style: TextStyle(fontSize: 15),
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
                onTap: () {
                  // TODO: Implement take photo feature

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  // TODO: Implement choose from gallery feature

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
