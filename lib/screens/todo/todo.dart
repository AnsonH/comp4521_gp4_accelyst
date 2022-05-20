import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:comp4521_gp4_accelyst/models/todo/todo_storage.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/edit_task.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/empty_todo_hint.dart';
import 'package:comp4521_gp4_accelyst/widgets/todo/task.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  // To be updated when we load from local storage
  TodoItems data = const TodoItems([]);

  // To be set in initState
  late final TodoStorage todoStorage;

  @override
  void initState() {
    super.initState();

    // Initializes storage service and load from JSON
    todoStorage = TodoStorage(callback: () {
      loadTodoData();
    });
  }

  /// Loads from the latest JSON data file and re-renders.
  Future<void> loadTodoData() async {
    final TodoItems loadedData = await todoStorage.loadJsonData();
    setState(() => data = loadedData);
  }

  /// Deletes the corresponding task in `data` and saves to JSON.
  Future<void> deleteTaskData(String id) async {
    setState(() {
      data.todoItems.removeWhere((element) => element.id == id);
    });
    await todoStorage.saveToJson(data);
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
      body: (data.todoItems.isNotEmpty)
          ? CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Task(
                        todoitem: data.todoItems[index],
                        onDelete: () =>
                            deleteTaskData(data.todoItems[index].id),
                      );
                    },
                    childCount: data.todoItems.length,
                  ),
                ),
              ],
            )
          : const EmptyTodoHint(),

      /// Button to Add New Task
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Create New Task
          TodoItem newTask = TodoItem(
            id: const Uuid().v4(),
            name: "",
            priority: TodoPriority.none,
            category: "",
            description: "",
            deadline: DateTime.now(),
            subtasks: [],
          );

          // Append the New Task to the Task List
          data.todoItems.add(newTask);

          // Save the updated `data` to JSON first
          await todoStorage.saveToJson(data);

          /// Navigate to the Edit Task page
          Navigator.push<TodoItem?>(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => EditTask(
                title: "Add Task",
                todoitem: newTask,
                onDelete: () => deleteTaskData(newTask.id),
              ),
            ),
          ).then((TodoItem? item) {
            if (item != null) {
              todoStorage.updateTodoItemAndSave(item);

              // Force re-render as `todoitem` is mutated
              setState(() {});
            } else {
              // Delete the `newTask` from JSON
              deleteTaskData(newTask.id);
            }
          });
        },
        heroTag: null,
      ),
    );
  }
}
