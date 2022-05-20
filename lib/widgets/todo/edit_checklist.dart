import 'package:flutter/material.dart';

/// EditChecklist() returns a Row() of checklist for read and write
/// This is used in the "edit_task.dart"
class EditChecklist extends StatefulWidget {
  final String id;
  String checklistName;
  bool done;
  final void Function() onDelete;
  final TextEditingController controller;

  ///Constructor
  EditChecklist({
    Key? key,
    required this.id,
    required this.checklistName,
    required this.onDelete,
    this.done = false,
    required this.controller,
  });

  @override
  State<EditChecklist> createState() => _EditChecklistState();
}

class _EditChecklistState extends State<EditChecklist> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20.0,
          child: Checkbox(
            value: widget.done,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (bool? newValue) {
              setState(() {
                widget.done = !widget.done;
              });
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            decoration: const InputDecoration(),
          ),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            onPressed: () {
              widget.onDelete();
            },
            child: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}
