import 'package:flutter/material.dart';
import 'package:eatak/models/todo_model.dart';

class CategoryButton extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
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
    final color = getCategoryColor(category);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.3)
              : Color.fromRGBO(244, 244, 244, 0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          category.displayName,
          style: TextStyle(
            color: isSelected ? color : Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
