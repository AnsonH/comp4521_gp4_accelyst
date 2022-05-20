import 'package:flutter/material.dart';

/// EditChecklist() returns a Row() of checklist for read and write
/// This is used in the "edit_task.dart"
class EditChecklist extends StatefulWidget {
  final String id;
  final bool initCheckboxVal;
  final void Function() onDelete;
  final TextEditingController controller;
  final void Function(bool) onChangeCheckbox;

  ///Constructor
  const EditChecklist({
    Key? key,
    required this.id,
    required this.onDelete,
    this.initCheckboxVal = false,
    required this.controller,
    required this.onChangeCheckbox,
  }) : super(key: key);

  @override
  State<EditChecklist> createState() => _EditChecklistState();
}

class _EditChecklistState extends State<EditChecklist> {
  late bool checkboxVal = widget.initCheckboxVal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20.0,
          child: Checkbox(
            value: checkboxVal,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (bool? newValue) {
              setState(() {
                checkboxVal = newValue!;
                widget.onChangeCheckbox(checkboxVal);
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
            child: Icon(
              Icons.delete,
              color: Colors.red[600],
            ),
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
