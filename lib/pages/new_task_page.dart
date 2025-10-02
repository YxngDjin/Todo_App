import 'package:eatak/components/category_button.dart';
import 'package:flutter/material.dart';
import 'package:eatak/models/todo_model.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _taskController = TextEditingController();
  final _subtaskController = TextEditingController();

  Category _category = Category.others;
  List<Subtask> _subtasks = [];

  @override
  void dispose() {
    _taskController.dispose();
    _subtaskController.dispose();
    super.dispose();
  }

  void addSubtask() {
    if (_subtaskController.text.isNotEmpty) {
      setState(() {
        _subtasks.add(Subtask(title: _subtaskController.text));
        _subtaskController.clear();
      });
    }
  }

  void _saveTask() {
    final taskText = _taskController.text.trim();
    if (taskText.isEmpty) return;

    final newTodo = Todo(
      task: taskText,
      subtasks: _subtasks,
      category: _category,
    );
    Navigator.of(context).pop(newTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _taskController,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Colors.black,
                      maxLines: null,
                      minLines: 1,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write a new task...",
                        hintStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(value: false, onChanged: (null)),
                              Expanded(
                                child: TextField(
                                  controller: _subtaskController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Add a subtask...",
                                    hintStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CategoryButton(
                      category: Category.health,
                      isSelected: _category == Category.health,
                      onTap: () {
                        setState(() {
                          _category = Category.health;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    CategoryButton(
                      category: Category.mentalHealth,
                      isSelected: _category == Category.mentalHealth,
                      onTap: () {
                        setState(() {
                          _category = Category.mentalHealth;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    CategoryButton(
                      category: Category.work,
                      isSelected: _category == Category.work,
                      onTap: () {
                        setState(() {
                          _category = Category.work;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    CategoryButton(
                      category: Category.others,
                      isSelected: _category == Category.others,
                      onTap: () {
                        setState(() {
                          _category = Category.others;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _saveTask,
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        const Color.fromRGBO(57, 52, 51, 1),
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
