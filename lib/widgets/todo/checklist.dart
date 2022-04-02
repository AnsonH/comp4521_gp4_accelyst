import 'package:flutter/material.dart';

class Checklist extends StatefulWidget {
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
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
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
        Text(widget.id),
        const SizedBox(width: 15),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(),
            initialValue: widget.checklistName,
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
            child: Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}
