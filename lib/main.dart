import 'package:eatak/components/homecard.dart';
import 'package:eatak/pages/new_task_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:eatak/models/todo_model.dart';
import 'package:eatak/components/todolist.dart';
import 'package:eatak/dummyData/dummy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Design',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.light(),
        primaryColor: Colors.black,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> todos = dummyTodos;

  Map<Category, int> categoryCount() {
    Map<Category, int> counts = {
      Category.health: 0,
      Category.mentalHealth: 0,
      Category.work: 0,
      Category.others: 0,
    };

    for (var todo in todos) {
      counts[todo.category] = counts[todo.category]! + 1;
    }

    return counts;
  }

  void _addTodo(Todo todo) {
    setState(() {
      todos.add(todo);
    });
  }

  void _removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  void _toggleSubtask(int todoIndex, int subtaskIndex) {
    setState(() {
      todos[todoIndex].subtasks[subtaskIndex].isDone =
          !todos[todoIndex].subtasks[subtaskIndex].isDone;
    });
  }

  void _deleteSubtask(int todoIndex, int subtaskIndex) {
    setState(() {
      todos[todoIndex].subtasks.removeAt(subtaskIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final counts = categoryCount();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Today",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                DateFormat("d MMM").format(DateTime.now()),
                style: const TextStyle(fontSize: 34, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 280,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Homecard(
                      iconpath: "assets/icons/heart.svg",
                      text: "Health",
                      number: counts[Category.health] ?? 0,
                      color: Color.fromARGB(70, 121, 144, 248),
                    ),
                    Homecard(
                      iconpath: "assets/icons/tablet.svg",
                      text: "Work",
                      number: counts[Category.work] ?? 0,
                      color: Color.fromARGB(70, 70, 207, 139),
                    ),
                    Homecard(
                      iconpath: "assets/icons/heart-hand.svg",
                      text: "Mental Health",
                      number: counts[Category.mentalHealth] ?? 0,
                      color: Color.fromARGB(70, 188, 94, 173),
                    ),
                    Homecard(
                      iconpath: "assets/icons/folder.svg",
                      text: "Others",
                      number: counts[Category.others] ?? 0,
                      color: Color.fromARGB(70, 144, 137, 134),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoList(
                    todo: todo,
                    onToggle: () => _toggleTodo(index),
                    onDelete: () => _removeTodo(index),
                    onSubtaskToggle: (subIndex) =>
                        _toggleSubtask(index, subIndex),
                    onSubtaskDelete: (subtaskIndex) =>
                        _deleteSubtask(index, subtaskIndex),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(57, 52, 51, 1),
        onPressed: () async {
          final newTodo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTaskPage()),
          );

          if (newTodo != null && newTodo is Todo) {
            _addTodo(newTodo);
          }
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
