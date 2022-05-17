import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:flutter/material.dart';

/// Represents status
enum TodoStatus { incomplete, complete }

class Task extends StatefulWidget {
  TodoItem todoitem;

  Task({required this.todoitem});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

      ///color: Colors.green,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: <Widget>[
          /// Checkbox
          SizedBox(
              width: 20.0,
              child: Checkbox(
                /// Checkbox: Ticked or not depends on "Todoitem.status" is "complete" or "incomplete"
                /// Todo: Fix the Checkbox part
                value: true,
                // (widget.todoitem.status == TodoStatus.incomplete)
                //     ? true
                //     : false,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (bool? newValue) {
                  setState(() {
                    if (widget.todoitem.status == TodoStatus.incomplete)
                      ;
                    else
                      ;
                  });
                },

                /// Checkbox: Different color with different priorities
                ///   High: Red, Medium: Yellow, Low: Green, None: Grey
                activeColor: widget.todoitem.priority == TodoPriority.high
                    ? Colors.red[700]
                    : widget.todoitem.priority == TodoPriority.medium
                        ? Colors.amber[800]
                        : widget.todoitem.priority == TodoPriority.low
                            ? Colors.green[700]
                            : Colors.grey[800],
              )),

          /// Below contains all Text Contents
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Update the hardcoded value to proper variables
              /// Task Name
              Text(
                widget.todoitem.name,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 3.0),
              Row(
                children: <Widget>[
                  /// Task Deadline
                  /// Todo: Apply the Deadline variable (with DateTime Format)
                  Text(
                    //widget.todoitem.deadline
                    "10:30pm",
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  /// Task Category (or Subject)
                  Text(
                    widget.todoitem.category,
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                ],
              ),
            ],
          ),

          /// Icon for each Task
          /// Todo: Deal with the "Overflow by Pixels" Problem
          /// Todo: Make the grey circle (pops up when button clicked) to be above the BoxDecoration()
          /// TODO: Add a Sliding Animation to expose the menu for each task
          Expanded(child: SizedBox()),
          IconButton(
            onPressed: () {},
            iconSize: 20.0,
            icon: Icon(Icons.more_vert),
            splashColor: Colors.grey,
            splashRadius: 20.0,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
