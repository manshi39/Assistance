import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/expense.dart';
import 'package:login/login/todo.dart';



import 'package:login/task.dart';void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor:Color.fromARGB(237, 96, 57,158),
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(300),
                ),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  ElevatedButton(
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Todo()), // Navigate to TodoPage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            color:
                                Theme.of(context).primaryColor.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: itemDashboard(
                        'Todo',
                        'assets/img3.jpg',
                        Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TaskPage()), // Navigate to TodoPage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                     // primary: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            color:
                                Theme.of(context).primaryColor.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: itemDashboard(
                        'Task',
                        'assets/img4.jpg',
                        Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExpensePage()), // Navigate to ExpensePage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                     // primary: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            color:
                                Theme.of(context).primaryColor.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: itemDashboard(
                        'Expence',
                        'assets/img5.jpg',
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget itemDashboard(
    String title,
    String imagePath,
    Color background,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
