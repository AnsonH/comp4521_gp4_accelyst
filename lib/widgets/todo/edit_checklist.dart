import 'package:flutter/material.dart';

/// EditChecklist() returns a Row() of checklist for read and write
/// This is used in the "edit_task.dart"

class EditChecklist extends StatefulWidget {
  // TODO: Remove `id` and `checklistName` fields with:
  final String id;
  String checklistName;
  bool done;
  final void Function() onDelete;
  final void Function(String, String, bool) onChange;

  ///Constructor
  EditChecklist({
    Key? key,
    required this.id,
    required this.checklistName,
    required this.onDelete,
    required this.onChange,
    this.done = false,
  });

  @override
  State<EditChecklist> createState() => _EditChecklistState();
}

class _EditChecklistState extends State<EditChecklist> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      // TODO: Update ChecklistData instance here
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.checklistName;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 20.0,
          child: Checkbox(
            value: widget.done,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (bool? newValue) {
              setState(() {
                widget.done = !widget.done;
                widget.onChange(widget.id, widget.checklistName, widget.done);
              });
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(),

            /// TODO: Replace onChanged. Currently, every word input will update the TextForm which makes it buggy
            onChanged: (String value) {
              widget.onChange(widget.id, value, widget.done);
            },
          ),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            onPressed: () {
              //Todo: Delete the checklist
              widget.onDelete();
            },
            child: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
