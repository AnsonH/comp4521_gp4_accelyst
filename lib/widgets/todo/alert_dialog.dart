import 'package:flutter/material.dart';

/// Call this function to pop up a Alert Dialog
/// Used to confirm "Delete" request for each task

showAlertDialog(BuildContext context, final void Function() onDelete) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: const Text("Delete"),
    onPressed: () {
      onDelete();
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete this To Do?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
