import 'package:flutter/material.dart';

/// EditChecklist() returns a Row() of checklist for read and write
/// This is used in the "edit_task.dart"

class EditChecklist extends StatefulWidget {
  // TODO: Remove `id` and `checklistName` fields with:
  final String id;
  final String checklistName;
  final void Function() onDelete;
  bool done;

  EditChecklist({
    Key? key,
    required this.id,
    required this.checklistName,
    required this.onDelete,
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
                widget.done = newValue!;
              });
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              /// TODO: Change the Checklist name variable stored in "edit_task.dart"
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
