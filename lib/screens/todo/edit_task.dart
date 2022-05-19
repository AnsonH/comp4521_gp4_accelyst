import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/edit_checklist.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// EditTask class which returns the Edit/Add Task Page
class EditTask extends StatefulWidget {
  /// Input varialbes for EditTask Class
  final String title;
  TodoItem todoitem;
  final void Function() onDelete;

  EditTask(
      {required this.title, required this.todoitem, required this.onDelete});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  /// This function deletes the corresponding ChecklistData.
  /// Called when the delete icon on the right side is clicked for each checklist
  void deleteChecklistData(String id) {
    setState(() {
      widget.todoitem.subtasks.removeWhere((element) => element.id == id);
    });
  }

  void changeChecklistData(String id, String name, bool done) {
    setState(() {
      int index =
          widget.todoitem.subtasks.indexWhere((element) => element.id == id);
      widget.todoitem.subtasks[index].name = name;
      widget.todoitem.subtasks[index].done = done;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Universal AppBar at the top of each page
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal[700],
        actions: <Widget>[
          /// TODO: Make the Back button prompt the alert dialog for discarding the changes
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context, widget.todoitem);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Delete event?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onDelete();
                      Navigator.pop(context); // Close dialogue
                      Navigator.pop(context, null); // Exit "Edit task" screen
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      /// Body of the Add/Edit Task Page
      body: Container(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          // Using slivers allow us to scroll the list and grid views together
          // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
          slivers: [
            /// Edit Task Name, Subject, and Description
            SliverList(
              delegate: SliverChildListDelegate([
                /// Edit the Name of the Task
                TextFormField(
                  decoration: const InputDecoration(labelText: "Task Name"),
                  readOnly: false,
                  initialValue: widget.todoitem.name,
                  onChanged: (String value) {
                    widget.todoitem.name = value;
                  },
                ),

                /// Edit the Subject/Category of the Task
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Subject"),
                  readOnly: false,
                  initialValue: widget.todoitem.category,
                  onChanged: (String value) {
                    widget.todoitem.category = value;
                  },
                ),

                /// Edit the Description of the Task
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Take as much lines as the input value
                  initialValue: widget.todoitem.description,
                  readOnly: false,
                  onChanged: (String value) {
                    widget.todoitem.description = value;
                  },
                ),

                /// Add/Edit Deadline of the Task
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Deadline: ",
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                    Text(
                      (widget.todoitem.deadline != null)
                          ? "${widget.todoitem.deadline!.day}/${widget.todoitem.deadline!.month}/${widget.todoitem.deadline!.year}"
                          : "",
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Expanded(child: SizedBox()),
                    TextButton.icon(
                      icon: const Icon(Icons.date_range),
                      label: const Text("Set Deadline"),
                      onPressed: () {
                        setState(() {
                          _selectDate(context);
                        });
                      },
                    ),
                  ],
                ),

                /// Subtitle "Checklists"
                const SizedBox(height: 25),
                Text(
                  "Checklists",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10),
              ]),
            ),

            /// Existing/Created Checklists
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return EditChecklist(
                    id: widget.todoitem.subtasks[index].id,
                    checklistName: widget.todoitem.subtasks[index].name,
                    done: widget.todoitem.subtasks[index].done,
                    onDelete: () =>
                        deleteChecklistData(widget.todoitem.subtasks[index].id),
                    onChange: changeChecklistData,
                  );
                },
                childCount:
                    widget.todoitem.subtasks.length, // Fix children length
              ),
            ),

            /// Button to Add New Checklist
            SliverList(
              delegate: SliverChildListDelegate([
                TextButton.icon(
                  onPressed: () {
                    /// Add a new checklist to the todoitem
                    setState(() {
                      widget.todoitem.subtasks.add(TodoSubtask(
                        /// Create a new id for new Checklist
                        id: const Uuid().v4(),
                        name: "",
                      ));
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Checklist"),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  /// Select Date Function
  /// Used to pick a date for the deadline of a task
  /// TODO: Update "selectedDate" to a variable that contains "widget.todoitem.deadline" when it's not null
  _selectDate(BuildContext context) async {
    DateTime selectedDate;

    /// Pass the set deadline OR today's date if deadline is null
    if (widget.todoitem.deadline == null) {
      selectedDate = DateTime.now();
    } else {
      selectedDate = widget.todoitem.deadline!;
    }

    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        helpText: "SELECT DEADLINE",
        cancelText: "CANCEL",
        confirmText: "SET DEADLINE");

    if (selected != null && selected != selectedDate) {
      setState(() {
        widget.todoitem.deadline = selected;
      });
    }
  }
}
