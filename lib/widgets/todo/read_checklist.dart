import 'package:flutter/material.dart';

/// ReadChecklist() returns a Row() of checklist for reading only
/// This is used in the "task.dart"

class ReadChecklist extends StatefulWidget {
  // TODO: Remove `id` and `checklistName` fields with:
  final String id;
  final String checklistName;
  bool done;
  final void Function(String, bool) onChange;

  ReadChecklist({
    Key? key,
    required this.id,
    required this.checklistName,
    this.done = false,
    required this.onChange,
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
              setState(() {
                widget.done = newValue!;
                widget.onChange(widget.id, widget.done);
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
