import 'package:eatak/models/todo_model.dart';

List<Todo> dummyTodos = [
  Todo(task: "Drink 8 glasses of water", category: Category.health),
  Todo(task: "Edit the PDF", category: Category.work),
  Todo(
    task: "Write in a gratitude journal",
    category: Category.mentalHealth,
    subtasks: [
      Subtask(title: "Get a notebook"),
      Subtask(title: "Follow the youtube tutorial"),
    ],
  ),
  Todo(task: "Stretch everyday for 15 mins"),
];
