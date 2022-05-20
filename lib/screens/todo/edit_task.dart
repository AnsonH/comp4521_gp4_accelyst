import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/edit_checklist.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// EditTask class which returns the Edit/Add Task Page
class EditTask extends StatefulWidget {
  final String title;

  /// We directly mutate this object. This object will be saved to JSON once we
  /// pop the "Edit Task" route and return back to Mnemonics home page.
  final TodoItem todoitem;

  final void Function() onDelete;

  EditTask({
    Key? key,
    required this.title,
    required this.todoitem,
    required this.onDelete,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  /// A map of the UUID of each subtask to its corresponding text controller.
  ///
  /// To be initialized in initState.
  final Map<String, TextEditingController> subtasksControllers = {};

  void _initializeSubtasksControllers() {
    for (var subtask in widget.todoitem.subtasks) {
      subtasksControllers[subtask.id] = TextEditingController();

      // Initial value of the text field
      subtasksControllers[subtask.id]!.text = subtask.name;
    }
  }

  /// Updates each [TodoSubtask] instance in `widget.todoitem.subtask` array.
  void _updateSubtasks() {
    for (var subtask in widget.todoitem.subtasks) {
      int i = widget.todoitem.subtasks.indexWhere((e) => e.id == subtask.id);
      widget.todoitem.subtasks[i].name = subtasksControllers[subtask.id]!.text;
    }
  }

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
  void initState() {
    super.initState();
    _initializeSubtasksControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Universal AppBar at the top of each page
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _updateSubtasks();
            Navigator.pop(context, widget.todoitem);
          },
        ),
        actions: <Widget>[
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

                /// Priority level
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Priority: ",
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 5),
                    DropdownButton<TodoPriority>(
                      value: widget.todoitem.priority,
                      items: const [
                        TodoPriority.none,
                        TodoPriority.low,
                        TodoPriority.medium,
                        TodoPriority.high,
                      ].map<DropdownMenuItem<TodoPriority>>((value) {
                        return DropdownMenuItem<TodoPriority>(
                          value: value,
                          child: Text(todoPriorityMap[value]!),
                        );
                      }).toList(),
                      onChanged: (TodoPriority? newValue) {
                        setState(() => widget.todoitem.priority = newValue!);
                      },
                    ),
                  ],
                ),

                /// Add/Edit Deadline of the Task
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Deadline: ",
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                    TextButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.todoitem.deadline != null
                                ? widget.todoitem.getDeadlineDate()
                                : "None",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          _selectDate(context);
                        });
                      },
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
                    const Expanded(child: SizedBox()),
                    if (widget.todoitem.deadline != null)
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red[600],
                        onPressed: () {
                          setState(() {
                            widget.todoitem.deadline = null;
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
                  final TodoSubtask subtask = widget.todoitem.subtasks[index];

                  return EditChecklist(
                    id: subtask.id,
                    initCheckboxVal: subtask.done,
                    onDelete: () => deleteChecklistData(subtask.id),
                    controller: subtasksControllers[subtask.id]!,
                    onChangeCheckbox: (bool newVal) {
                      subtask.done = newVal;
                    },
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
                    final newSubtask = TodoSubtask(
                      /// Create a new id for new Checklist
                      id: const Uuid().v4(),
                      name: "",
                    );

                    // Create new text controller
                    subtasksControllers[newSubtask.id] =
                        TextEditingController();

                    setState(() {
                      widget.todoitem.subtasks.add(newSubtask);
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

  @override
  void dispose() {
    // Dispose text controllers
    // NOTE: This is run AFTER saving the mutated widget.todoitem is saved back to JSON
    for (var controller in subtasksControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  /// Select Date Function
  /// Used to pick a date for the deadline of a task
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
