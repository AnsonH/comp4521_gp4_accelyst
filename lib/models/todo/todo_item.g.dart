// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItems _$TodoItemsFromJson(Map<String, dynamic> json) => TodoItems(
      (json['todoItems'] as List<dynamic>)
          .map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoItemsToJson(TodoItems instance) => <String, dynamic>{
      'todoItems': instance.todoItems.map((e) => e.toJson()).toList(),
    };

TodoSubtask _$TodoSubtaskFromJson(Map<String, dynamic> json) => TodoSubtask(
      id: json['id'] as String,
      name: json['name'] as String,
      done: json['done'] as bool? ?? false,
    );

Map<String, dynamic> _$TodoSubtaskToJson(TodoSubtask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'done': instance.done,
      'name': instance.name,
    };

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      priority: $enumDecode(_$TodoPriorityEnumMap, json['priority']),
      description: json['description'] as String,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      subtasks: (json['subtasks'] as List<dynamic>)
          .map((e) => TodoSubtask.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..isComplete = json['isComplete'] as bool;

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'isComplete': instance.isComplete,
      'name': instance.name,
      'category': instance.category,
      'priority': _$TodoPriorityEnumMap[instance.priority],
      'description': instance.description,
      'deadline': instance.deadline?.toIso8601String(),
      'subtasks': instance.subtasks.map((e) => e.toJson()).toList(),
    };

const _$TodoPriorityEnumMap = {
  TodoPriority.none: 'none',
  TodoPriority.low: 'low',
  TodoPriority.medium: 'medium',
  TodoPriority.high: 'high',
};
