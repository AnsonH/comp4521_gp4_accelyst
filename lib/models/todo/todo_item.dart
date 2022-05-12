/// Represents status
enum TodoStatus { incomplete, complete }

/// Represents priority level
enum TodoPriority { none, low, medium, high }

/// Represents subtask
class TodoSubtask {
  bool done;
  String name;

  TodoSubtask({
    required this.name,
    this.done = false,
  });

  void click() {
    done = !done;
  }
}

/// Represents a To-do List Item
class TodoItem {
  /// UUID of item
  final String id;

  /// Status of to-do item
  TodoStatus status = TodoStatus.incomplete;

  /// Name of to-do item
  String name;

  /// Category of to-do item, e.g. course/commitment
  String category;

  /// Priority level of to-do item
  TodoPriority priority;

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
    required this.priority,
    required this.category,
    required this.description,
    this.deadline,
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
    String dateStr = d.month.toString().substring(0, 3);
    dateStr = d.day.toString();
    dateStr += d.hour.toString();
    dateStr += ":";
    dateStr += d.minute.toString();
    return dateStr;
  }

  void set setName(String newName) {
    name = newName;
  }

  void set setPriority(TodoPriority newPriority) {
    priority = newPriority;
  }

  void set setStatus(TodoStatus newStatus) {
    status = newStatus;
  }

  void set setCategory(String newCategory) {
    category = newCategory;
  }

  void set setDescription(String newDescription) {
    description = newDescription;
  }

  void set setDeadline(DateTime? newDeadline) {
    deadline = newDeadline;
  }

  void set setSubtasks(List<TodoSubtask> newSubtasks) {
    subtasks = newSubtasks;
  }
}
