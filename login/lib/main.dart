import 'package:flutter/material.dart';
import 'package:login/expense.dart';
import 'package:login/login/dashboard.dart';
import 'package:login/login/phone.dart';
import 'package:login/login/otp.dart';
import 'package:login/login/todo.dart';
import 'package:login/task.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';




Future<void> main () async {
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {'phone' : (context) => MyPhone(), 'otp' : (context) =>  MyVerify(), 'dashboard' :(context) => MyApp(), 'todo' :(context) => Todo(),'task':(context) => TaskPage() ,
     'expense':(context) => ExpensePage(),
    //  'expenses':(context) => Expense()
    },
  ));
}
  
