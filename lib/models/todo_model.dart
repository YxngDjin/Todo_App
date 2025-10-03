import 'dart:convert';

enum Category { health, mentalHealth, work, others }

class Todo {
  int? id;
  String task;
  bool isDone;
  List<Subtask> subtasks;
  Category category;

  Todo({
    this.id,
    required this.task,
    this.isDone = false,
    this.subtasks = const [],
    this.category = Category.others,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isDone': isDone ? 1 : 0,
      'subtasks': jsonEncode(subtasks.map((s) => s.toMap()).toList()),
      'category': category.index,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      task: map['task'],
      isDone: map['isDone'] == 1,
      subtasks: (jsonDecode(map['subtasks']) as List)
          .map((s) => Subtask.fromMap(s))
          .toList(),
      category: Category.values[map['category']],
    );
  }
}

class Subtask {
  String title;
  bool isDone;
  Subtask({required this.title, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {'title': title, 'isDone': isDone ? 1 : 0};
  }

  factory Subtask.fromMap(Map<String, dynamic> map) {
    return Subtask(title: map['title'], isDone: map['isDone'] == 1);
  }
}

extension CategoryExtension on Category {
  String get displayName {
    switch (this) {
      case Category.health:
        return "Health";
      case Category.work:
        return "Work";
      case Category.mentalHealth:
        return "Mental Health";
      case Category.others:
        return "Others";
    }
  }
}
