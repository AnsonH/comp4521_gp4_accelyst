import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
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
      action: SnackBarAction(
        label: "OK",
        textColor: secondaryColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      // behavior: SnackBarBehavior.floating,
    ),
  );
}
