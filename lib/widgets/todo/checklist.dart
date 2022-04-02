import 'package:comp4521_gp4_accelyst/models/checklist_data.dart';
import 'package:flutter/material.dart';

class Checklist extends StatefulWidget {
  // TODO: Remove `id` and `checklistName` fields with:
  // final ChecklistData checklistData;
  final String id;
  final String checklistName;
  final void Function() onDelete;

  const Checklist({
    Key? key,
    required this.id,
    required this.checklistName,
    required this.onDelete,
  });

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  final _controller = TextEditingController();

  // TODO: Use ChecklistData's `isChecked` property
  bool isChecked = false;

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
            value: isChecked,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (bool? newValue) {
              setState(() {
                isChecked = newValue!;
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
