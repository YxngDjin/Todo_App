import 'package:flutter/material.dart';
import 'package:eatak/models/todo_model.dart';

class TodoList extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoList({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
