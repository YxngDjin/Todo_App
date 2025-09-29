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
}

class Subtask {
  String title;
  bool isDone;
  Subtask({required this.title, this.isDone = false});
}
