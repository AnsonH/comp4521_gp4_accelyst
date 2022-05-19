import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part "todo_item.g.dart";

/// Represents priority level
enum TodoPriority {
  @JsonValue("none")
  none,

  @JsonValue("low")
  low,

  @JsonValue("medium")
  medium,

  @JsonValue("high")
  high,
}

/// Stores a list of all todo items. Used in the "Todo" homepage.
@JsonSerializable()
class TodoItems {
  final List<TodoItem> todoItems;

  const TodoItems(this.todoItems);

  factory TodoItems.fromJson(Map<String, dynamic> json) =>
      _$TodoItemsFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemsToJson(this);
}

/// Represents subtask
@JsonSerializable()
class TodoSubtask {
  final String id;
  bool done;
  String name;

  TodoSubtask({
    required this.id,
    required this.name,
    this.done = false,
  });

  void click() {
    done = !done;
  }

  factory TodoSubtask.fromJson(Map<String, dynamic> json) =>
      _$TodoSubtaskFromJson(json);

  Map<String, dynamic> toJson() => _$TodoSubtaskToJson(this);
}

/// Represents a To-do List Item
@JsonSerializable()
class TodoItem {
  /// UUID of item
  final String id;

  /// Status of to-do item
  bool isComplete = false;

  /// Name of to-do item
  String name;

  /// Category of to-do item, e.g. course/commitment
  String category;

  /// Priority level of to-do item
  TodoPriority priority = TodoPriority.none;

  /// Description of to-do item
  String description;

  /// Deadline of to-do item
  DateTime? deadline;

  /// Subtasks under to-do item
  List<TodoSubtask> subtasks = [];

  // /// Soft deadline of to-do item
  // DateTime? soft_deadline;

  /// Constructor
  TodoItem({
    required this.id,
    required this.name,
    required this.category,
    required this.priority,
    required this.description,
    required this.deadline,
    required this.subtasks,
  });

  /// Compares deadline with current time to decide if a to-do item is overdue
  bool isOverdue() {
    return (priority != TodoPriority.none)
        ? (DateTime.now().isAfter(deadline ?? DateTime.now()))
        : false;
  }

  /// Get: returns deadline in formatted String
  String getDeadlineString() {
    if (priority == TodoPriority.none) return "";
    if (deadline == null) return "";
    DateTime d = deadline ?? DateTime.now();
    String dateStr = DateFormat("MMM dd H:m").format(d);
    return dateStr;
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
