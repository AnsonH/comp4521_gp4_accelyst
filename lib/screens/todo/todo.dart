import 'package:comp4521_gp4_accelyst/screens/todo/edit_task.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  String _todoView = 'ListView'; // ListView or CalendarView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                (_todoView == 'ListView') ? Icons.calendar_today : Icons.sort),
            tooltip: 'Add new task',
            onPressed: () {
              setState(() {
                _todoView =
                    (_todoView == 'ListView') ? 'CalendarView' : 'ListView';
              });
            },
          ),
          PopupMenuButton<String>(
              onSelected: (String value) {},
              offset: Offset(0, 52),
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                      value: choice, child: Text(choice));
                }).toList();
              })
        ],
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Todo"),
      ),
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
