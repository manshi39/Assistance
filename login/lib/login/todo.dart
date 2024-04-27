import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/login/dashboard.dart'; 

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        backgroundColor:Color.fromARGB(237, 96, 57,158),
         leading: IconButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()), 
    );
  },
  icon: Icon(
    Icons.arrow_back_ios_rounded,
    color: Colors.black,
  ),
),

        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text('${task.date} ${task.day}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  tasks.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTask() {
    // Get current date and time
    var now = DateTime.now();
    // Format date
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    // Format day
    var dayFormatter = DateFormat('EEEE');
    String formattedDay = dayFormatter.format(now);
    // Open dialog to add task
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _taskController = TextEditingController();
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: 'Enter your task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(
                    name: _taskController.text,
                    date: formattedDate,
                    day: formattedDay,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Task {
  final String name;
  final String date;
  final String day;

  Task({required this.name, required this.date, required this.day});
}
