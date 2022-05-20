import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:comp4521_gp4_accelyst/models/todo/todo_storage.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/edit_task.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/alert_dialog.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/read_checklist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task extends StatefulWidget {
  TodoItem todoitem;
  final void Function() onDelete;

  Task({required this.todoitem, required this.onDelete});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late TodoItem todoitem = widget.todoitem;

  late final TodoStorage todoStorage;

  /// Expand the bottom popup bar when expandInfo is True
  bool expandInfo = false;

  void changeChecklistData(String id, bool done) {
    setState(() {
      int index = todoitem.subtasks.indexWhere((element) => element.id == id);
      todoitem.subtasks[index].done = done;
    });
    todoStorage.updateTodoItemAndSave(todoitem);
  }

  @override
  void initState() {
    super.initState();
    todoStorage = TodoStorage();
  }

  @override
  Widget build(BuildContext context) {
    // When widget.todoitem receives a brand new todoitem, we should update
    // the internal state `todoItem` to use the latest `widget.todoitem`.
    // This is necessary for the delete item to work.
    if (todoitem.id != widget.todoitem.id) {
      todoitem = widget.todoitem;
    }

    /// Column used to separate the two Large Widget ("Main Task Bar" vs. "Popup Task info & subtasks")
    return Column(
      /// GestureDetector used to detect user interaction with the Task Item
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              expandInfo = !expandInfo;
            });
          },

          /// This Container is the Box that encapsulates the Main Task Bar
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
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
                          todoitem.priority == TodoPriority.high
                              ? Colors.red[700]
                              : todoitem.priority == TodoPriority.medium
                                  ? Colors.amber[800]
                                  : todoitem.priority == TodoPriority.low
                                      ? Colors.green[700]
                                      : Colors.grey[800],
                    ),
                    child: Checkbox(
                      /// Checkbox: Ticked or not depends on "Todoitem.status" is "complete" or "incomplete"
                      value: todoitem.isComplete,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          todoitem.isComplete = !todoitem.isComplete;
                        });
                        await todoStorage.updateTodoItemAndSave(todoitem);
                      },

                      /// Checkbox: Different color with different priorities
                      ///   High: Red, Medium: Yellow, Low: Green, None: Grey
                      activeColor: todoitem.priority == TodoPriority.high
                          ? Colors.red[700]
                          : todoitem.priority == TodoPriority.medium
                              ? Colors.amber[800]
                              : todoitem.priority == TodoPriority.low
                                  ? Colors.green[700]
                                  : Colors.grey[800],
                    ),
                  ),
                ),

                /// Below contains all Text Contents
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// Update the hardcoded value to proper variables
                      /// Task Name
                      Text(
                        todoitem.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (todoitem.deadline != null || todoitem.category != "")
                        const SizedBox(height: 3.0),
                      Row(
                        children: <Widget>[
                          /// Task Deadline
                          ///   If Deadline is NULL then do NOT display the deadline
                          (todoitem.deadline != null)
                              ? Row(
                                  children: [
                                    Text(
                                      DateFormat.MMMMd()
                                          .format(todoitem.deadline!),
                                      style: TextStyle(color: primaryColor),
                                    ),
                                    const SizedBox(width: 10)
                                  ],
                                )
                              : const SizedBox(width: 0),

                          /// Task Category (or Subject)
                          if (todoitem.category != "")
                            Expanded(
                              child: Text(
                                todoitem.category,
                                style: TextStyle(color: Colors.grey[900]),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Bottom Side Popup Bar
        /// Expand the Popup Bar ONLY when the Task Bar is clicked
        (expandInfo)
            ? Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// Shows Description Text if it's not blank
                      (todoitem.description != "")
                          ? Column(children: [
                              const SizedBox(height: 15),
                              Text(
                                todoitem.description,
                                style: TextStyle(color: Colors.grey[800]),
                              )
                            ])
                          : const SizedBox(width: 0),

                      (todoitem.subtasks.isNotEmpty)
                          ? const SizedBox(height: 10)
                          : const SizedBox(),

                      /// Shows the Existing/Created Checklists/Subtasks
                      ...todoitem.subtasks.map((subtask) {
                        return ReadChecklist(
                          id: subtask.id,
                          checklistName: subtask.name,
                          done: subtask.done,
                          onChange: changeChecklistData,
                        );
                      }).toList(),

                      /// Edit and Delete button for each task
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Click to Edit the data of that task
                          TextButton(
                            onPressed: () {
                              Navigator.push<TodoItem?>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTask(
                                    title: "Edit Task",
                                    todoitem: todoitem,
                                    onDelete: () {
                                      widget.onDelete();
                                      // Close expand info panel after deleting
                                      setState(() => expandInfo = false);
                                    },
                                  ),
                                ),
                              ).then((TodoItem? item) {
                                if (item != null) {
                                  todoStorage.updateTodoItemAndSave(item);

                                  // Force re-render as `todoitem` is mutated
                                  setState(() {});
                                }
                              });
                            },
                            child: const Text("Edit"),
                          ),

                          TextButton(
                            onPressed: () {
                              showAlertDialog(context, widget.onDelete);
                            },
                            child: const Text("Delete"),
                          )
                        ],
                      )
                    ]),
              )
            : const SizedBox(),
      ],
    );
  }
}
