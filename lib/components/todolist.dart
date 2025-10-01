import 'package:flutter/material.dart';
import 'package:eatak/models/todo_model.dart';

class TodoList extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(int subtaskIndex) onSubtaskToggle;
  final Function(int subtaskIndex) onSubtaskDelete;

  const TodoList({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onSubtaskToggle,
    required this.onSubtaskDelete,
  });

  Color getCategoryColor(Category category) {
    switch (category) {
      case Category.health:
        return Color.fromRGBO(121, 144, 248, 1);
      case Category.work:
        return Color.fromRGBO(70, 207, 139, 1);
      case Category.mentalHealth:
        return Color.fromRGBO(188, 94, 173, 1);
      case Category.others:
        return Color.fromRGBO(144, 137, 134, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getCategoryColor(todo.category);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(value: todo.isDone, onChanged: (_) => onToggle()),
                Expanded(
                  child: Text(
                    todo.task,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                if (todo.isDone)
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onDelete(),
                    color: Colors.red,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  todo.category.displayName,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            if (todo.subtasks.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: todo.subtasks.map((subtask) {
                    return Row(
                      children: [
                        Checkbox(
                          value: subtask.isDone,
                          onChanged: (_) =>
                              onSubtaskToggle(todo.subtasks.indexOf(subtask)),
                        ),
                        Expanded(
                          child: Text(
                            subtask.title,
                            style: TextStyle(
                              fontSize: 14,
                              decoration: subtask.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                        if (subtask.isDone)
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                onSubtaskDelete(todo.subtasks.indexOf(subtask)),
                            color: Colors.red,
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            Container(margin: const EdgeInsets.only(bottom: 6)),
            Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
          ],
        ),
      ),
    );
  }
}
