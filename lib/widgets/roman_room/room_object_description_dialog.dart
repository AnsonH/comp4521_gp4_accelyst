import 'package:flutter/material.dart';

/// Show a dialog with text input for users to input the description of a
/// roman room item.
Future<String?> showRoomObjectDescriptionDialog({
  required BuildContext context,
  required TextEditingController controller,
}) {
  return showDialog<String?>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text("Input object description"),
      content: TextField(
        controller: controller,
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
            Navigator.pop(context, controller.text);
          },
          child: const Text("DONE"),
        ),
      ],
    ),
  );
}
