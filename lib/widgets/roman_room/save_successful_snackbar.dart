import 'package:flutter/material.dart';

void showSaveSuccessfulSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: const [
          Icon(Icons.done, color: Colors.white),
          SizedBox(width: 10),
          Text("Roman room saved successfully."),
        ],
      ),
      // behavior: SnackBarBehavior.floating,
    ),
  );
}
