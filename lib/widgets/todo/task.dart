import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  TodoItem todoitem;

  Task({required this.todoitem});

  int getDeadlineHour() {
    int? deadlineHour = todoitem.deadline?.hour;
    return 10;
  }

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
            child: Theme(
              data: Theme.of(context).copyWith(
                /// Checkbox: Color when box is unchecked
                ///   High: Red, Medium: Yellow, Low: Green, None: Grey
                unselectedWidgetColor:
                    widget.todoitem.priority == TodoPriority.high
                        ? Colors.red[700]
                        : widget.todoitem.priority == TodoPriority.medium
                            ? Colors.amber[800]
                            : widget.todoitem.priority == TodoPriority.low
                                ? Colors.green[700]
                                : Colors.grey[800],
              ),
              child: Checkbox(
                /// Checkbox: Ticked or not depends on "Todoitem.status" is "complete" or "incomplete"
                value: (widget.todoitem.status == TodoStatus.incomplete)
                    ? true
                    : false,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (bool? newValue) {
                  setState(() {
                    if (widget.todoitem.status == TodoStatus.incomplete)
                      widget.todoitem.status = TodoStatus.complete;
                    else
                      widget.todoitem.status = TodoStatus.incomplete;
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
              ),
            ),
          ),

          /// Below contains all Text Contents
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
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
                    ///   If Deadline is NULL then do NOT display the deadline
                    /// Todo: Apply the Deadline variable (with DateTime Format)
                    (widget.todoitem.deadline != null)
                        ? Row(
                            children: [
                              Text(
                                "Deadline here",
                                style: TextStyle(color: Colors.blue[800]),
                              ),
                              SizedBox(width: 10)
                            ],
                          )
                        : SizedBox(width: 0),

                    /// Task Category (or Subject)
                    Text(
                      widget.todoitem.category,
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
