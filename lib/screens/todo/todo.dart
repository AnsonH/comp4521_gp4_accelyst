import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/edit_task.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/task.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
      description: "Memorize the top 1000 common English words",
      deadline: DateTime.parse('2022-05-06 20:00'),
      subtasks: [
        TodoSubtask(
            id: const Uuid().v4(),
            name: "Create a vocabulary list",
            done: true),
        TodoSubtask(
            id: const Uuid().v4(), name: "Memorize all the words", done: false),
      ],
    ),
    TodoItem(
      id: const Uuid().v4(),
      name: "Complete Supplementary Exercise",
      priority: TodoPriority.low,
      category: "Math",
      description: "",
      deadline: null,
      subtasks: [
        TodoSubtask(
            id: const Uuid().v4(), name: "Exercise Part A", done: false),
        TodoSubtask(
            id: const Uuid().v4(), name: "Exercise Part B", done: false),
      ],
    ),
    TodoItem(
      id: const Uuid().v4(),
      name: "Send Email to Your Professor",
      priority: TodoPriority.high,
      category: "Humanities",
      description: "",
      deadline: null,
      subtasks: [],
    ),
    TodoItem(
      id: const Uuid().v4(),
      name: "Workout",
      priority: TodoPriority.none,
      category: "",
      description: "",
      deadline: null,
      subtasks: [],
    ),
    TodoItem(
      id: const Uuid().v4(),
      name: "Testing",
      priority: TodoPriority.none,
      category: "asdfjkl;asdfjaklsdfajsdkfl;asdfjaklsdfajskdf;asdfjakls;df",
      description: "",
      deadline: DateTime.parse('2022-05-06 22:00'),
      subtasks: [],
    ),
  ];

  /// This function deletes the corresponding Task.
  /// Called when the delete button in the bottom popup bar is clicked for each task
  void deleteTaskData(String id) {
    setState(() {
      tempTasks.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Top AppBar
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      drawer: const NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.4,
      backgroundColor: Colors.grey[200],

      /// Body of the To-do Home Page
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Task(
                  todoitem: tempTasks[index],
                  onDelete: () => deleteTaskData(tempTasks[index].id),
                );
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
          /// Create New Task
          TodoItem newTask = TodoItem(
            id: const Uuid().v4(),
            name: "",
            priority: TodoPriority.none,
            category: "",
            description: "",
            deadline: DateTime.now(),
            subtasks: [],
          );

          /// Append the New Task to the Task List
          tempTasks.add(newTask);

          /// Navigate to the Edit Task page
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => EditTask(
                title: "Add Task",
                todoitem: newTask,
                onDelete: () => deleteTaskData(newTask.id),
              ),
            ),
          );
        },
        heroTag: null,
      ),
    );
  }
}
