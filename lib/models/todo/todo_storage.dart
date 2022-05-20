import 'dart:convert';

import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

class TodoStorage extends StorageService {
  /// [callback] is called after initializing the storage service.
  TodoStorage({void Function()? callback}) {
    super
        .initialize(
      datapath: "todo",
      filename: "todo.json",
    )
        .then((_) async {
      // Create the JSON file if not exist
      if (!isFilePathExist) {
        final initialData = TodoItems([
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
                  id: const Uuid().v4(),
                  name: "Memorize all the words",
                  done: false),
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
        ]);
        String json = jsonEncode(initialData);
        await save(json);
      }

      if (callback != null) {
        callback();
      }
    });
  }

  /// Load data from the JSON file.
  Future<TodoItems> loadJsonData() async {
    final Map<String, dynamic> json = await read();
    return TodoItems.fromJson(json);
  }

  /// Save data into JSON file.
  Future<void> saveToJson(TodoItems data) async {
    final json = jsonEncode(data);
    await save(json);
  }

  /// Updates a single todo item and saves to JSON.
  Future<void> updateTodoItemAndSave(TodoItem item) async {
    final data = await loadJsonData();
    final itemIndex = data.todoItems.indexWhere((e) => e.id == item.id);

    // Delete and add back the item
    data.todoItems.removeAt(itemIndex);
    data.todoItems.insert(itemIndex, item);

    // Save to JSON
    await saveToJson(data);
  }
}
