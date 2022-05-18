import 'package:flutter/material.dart';

/// ReadChecklist() returns a Row() of checklist for reading only
/// This is used in the "task.dart"

class ReadChecklist extends StatefulWidget {
  // TODO: Remove `id` and `checklistName` fields with:
  final String id;
  final String checklistName;
  bool done;

  ReadChecklist({
    Key? key,
    required this.id,
    required this.checklistName,
    this.done = false,
  });

  @override
  State<ReadChecklist> createState() => _ReadChecklistState();
}

class _ReadChecklistState extends State<ReadChecklist> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /// Checkbox for each Checklist/Subtask
        SizedBox(
          width: 20.0,
          height: 30.0,
          child: Checkbox(
            value: widget.done,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (bool? newValue) {
              /// TODO: Make sure the Checkbox value retains when it the section is closed then opened again
              setState(() {
                widget.done = newValue!;
              });
            },
          ),
        ),

        /// Checklist Name
        const SizedBox(width: 10),
        Expanded(
          child: Text(widget.checklistName),
        ),
      ],
    );
  }
}
