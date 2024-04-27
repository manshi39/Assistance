import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore

class Task {
  final String title;
  final String note;
  final String startTime;
  final String endTime;
  final bool remind;
  final String repeat;
  final Color colorTheme;

  Task({
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.repeat,
    required this.colorTheme,
  });
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String title = '';
  String note = '';
  String startTime = '';
  String endTime = '';
  bool remind = false;
  String repeat = '';
  Color colorTheme = Color.fromARGB(255, 246, 247, 248); // Default color theme

  late FirebaseFirestore firestore; // Firestore instance

  // List to store tasks
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    initializeFlutterFire(); // Initialize Firebase when the app starts
  }

Future<void> initializeFlutterFire() async {
  try {
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
          appBar: AppBar(
            title: Text("Task"),
            backgroundColor: Color.fromARGB(237, 96, 57, 158),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
            elevation: 0,
          ),
          body: Container(
            color: colorTheme, 
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputBox('Title', onChanged: (value) => title = value),
                _buildInputBox('Note', onChanged: (value) => note = value),
                _buildInputBox('Start Time', onChanged: (value) => startTime = value),
                _buildInputBox('End Time', onChanged: (value) => endTime = value),
                Row(
                  children: [
                    Text('Remind', style: TextStyle(fontWeight: FontWeight.bold)), 
                    SizedBox(width: 10),
                    Checkbox(
                      value: remind,
                      onChanged: (value) {
                        setState(() {
                          remind = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                _buildInputBox('Repeat', onChanged: (value) => repeat = value),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Color Theme', style: TextStyle(fontWeight: FontWeight.bold)), 
                    SizedBox(width: 10),
                    _buildColorThemeButton(Color.fromARGB(255, 251, 251, 252)),
                    _buildColorThemeButton(Color.fromARGB(255, 236, 176, 247)),
                    _buildColorThemeButton(Color.fromARGB(255, 211, 189, 250)),
                    _buildColorThemeButton(Color.fromARGB(255, 200, 181, 247)),
                    _buildColorThemeButton(Color.fromARGB(255, 195, 153, 202)),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _addTaskToList();
                  },
                  child: Text('Create Task'),
                ),
              ],
            ),
          ),
        ),
      },
    );
  }

  Widget _buildInputBox(String label, {void Function(String)? onChanged}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2), 
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        style: TextStyle(fontWeight: FontWeight.bold), 
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildColorThemeButton(Color color) {
    bool isSelected = color == colorTheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          colorTheme = color;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
      ),
    );
  }

  // Method to add task to the list
  void _addTaskToList() async {
    try {
      await firestore.collection('tasks').add({
        'title': title,
        'note': note,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'repeat': repeat,
        'colorTheme': colorTheme.value, // Store color as int value
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task created successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create task')));
    }
  }
}

void main() {
  runApp(TaskPage());
}
