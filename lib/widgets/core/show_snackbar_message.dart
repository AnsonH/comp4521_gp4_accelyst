import 'package:flutter/material.dart';

void showSnackbarMessage(BuildContext context,
    {required bool success, required String message}) {
  // Remove current snackbar if any
  // ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).removeCurrentSnackBar(); // Skips animation

  // Add this snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(success ? Icons.done : Icons.error_outline,
              color: success ? Colors.white : Colors.red),
          const SizedBox(width: 10),
          Text(message),
        ],
      ),
      duration: const Duration(
        seconds: 2,
        // milliseconds: 500,
      ),
      // behavior: SnackBarBehavior.floating,
    ),
  );
}
