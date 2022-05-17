import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/edit_task.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/task.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// TODO: Import todo_item.dart and use its function

enum TodoView { list, calendar }

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  // TODO: Remove and Replace the Temporary task list
  List<TodoItem> tempTasks = [
    TodoItem(
      id: const Uuid().v4(),
      name: "Revise for Vocabulary Quiz",
      priority: TodoPriority.medium,
      category: "English",
      description: "Revise for Vocabulary Quiz",
      deadline: null,
    ),
    TodoItem(
      id: const Uuid().v4(),
      name: "Complete Supplementary Exercise",
      priority: TodoPriority.low,
      category: "Math",
      description: "",
      deadline: null,
    ),
    TodoItem(
      id: const Uuid().v4(),
      name: "Send Email to Your Professor ",
      priority: TodoPriority.high,
      category: "Humanities",
      description: "",
      deadline: null,
    ),
  ];

  // default mode: list view
  TodoView _todoView = TodoView.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Top AppBar
      appBar: AppBar(
        title: const Text("Todo"),
        actions: <Widget>[
          IconButton(
            icon: Icon((_todoView == TodoView.list)
                ? Icons.calendar_today
                : Icons.sort),
            tooltip: (_todoView == TodoView.list)
                ? "Change to Calendar View"
                : "Change to List View",
            onPressed: () {
              setState(() {
                _todoView = (_todoView == TodoView.list)
                    ? TodoView.calendar
                    : TodoView.list;
              });
            },
          ),
          PopupMenuButton<String>(
              onSelected: (String value) {},
              offset: const Offset(0, 52),
              itemBuilder: (BuildContext context) {
                return ['Logout', 'Settings'].map((String choice) {
                  return PopupMenuItem<String>(
                      value: choice, child: Text(choice));
                }).toList();
              })
        ],
      ),
      drawer: const NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.4,

      /// Body of the To-do Home Page
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // TODO: Add the task.dart function into this part
                return Task(todoitem: tempTasks[index]);
              },
              childCount: tempTasks.length,
            ),
          ),
        ],
      ),

      /// Button to Add New Task
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  const EditTask(title: "Add Task"),
            ),
          );
        },
      ),
    );
  }
}
