import 'package:comp4521_gp4_accelyst/screens/todo/edit_task.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/todo_calendar.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:flutter/material.dart';

enum TodoView { list, calendar }

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  // default mode: list view
  TodoView _todoView = TodoView.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(children: [
        (_todoView == TodoView.calendar)
            ? new TodoCalendar()
            : Text("List View, to be implemented"),
      ]),
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
