import 'package:comp4521_gp4_accelyst/models/checklist_data.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/checklist.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EditTask extends StatefulWidget {
  final String title;
  const EditTask({Key? key, this.title = "Edit Task"}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  List<ChecklistData> _checklistData = [
    ChecklistData(id: const Uuid().v4(), checklistName: "One"),
    ChecklistData(id: const Uuid().v4(), checklistName: "Two"),
    ChecklistData(id: const Uuid().v4(), checklistName: "Three"),
  ];

  void deleteChecklistData(String id) {
    final List<ChecklistData> newList = List.from(_checklistData);
    newList.removeWhere((element) => element.id == id);

    setState(() {
      _checklistData = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal[700],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
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
                      Navigator.pop(context); // Close dialogue
                      // TODO: Delete the task
                      Navigator.pop(context); // Exit "Edit task" screen
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          // Using slivers allow us to scroll the list and grid views together
          // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                TextFormField(
                  decoration: const InputDecoration(labelText: "Task Name"),
                  readOnly: false,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Subject"),
                  readOnly: false,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Take as much lines as the input value
                  initialValue: "Sample Text\nMiddle Text\nBottom Text",
                  readOnly: false,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                ),
                const SizedBox(height: 25),
                Text(
                  "Checklists",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10),
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Checklist(
                    id: _checklistData[index].id,
                    checklistName: _checklistData[index].checklistName,
                    onDelete: () =>
                        deleteChecklistData(_checklistData[index].id),
                  );
                },
                childCount: _checklistData.length, // Fix children length
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                TextButton.icon(
                  onPressed: () {
                    final String id = const Uuid().v4();

                    setState(() {
                      _checklistData.add(ChecklistData(
                        id: id,
                        checklistName: "",
                      ));
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text("Checklist"),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
