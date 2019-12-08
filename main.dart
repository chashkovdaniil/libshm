import 'package:flutter/material.dart';
import 'package:hello_world/Pages/Home/HomePage.dart';
import 'package:hello_world/Pages/About/AboutPage.dart';
import 'package:hello_world/Pages/Shedule/EditShedulePage.dart';
import 'package:hello_world/Pages/Homework/EditHomeworkPage.dart';
import 'package:hello_world/subjects.dart';

bool auth = true;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(BuildContext context) => HomePage(),
        '/about':(BuildContext context) => AboutPage(),
        '/subjects':(BuildContext context) => SubjectsPage(),
        '/editShedule':(BuildContext context) => EditShedulePage(),
        '/homework':(BuildContext context) => HomeworkPage()
      },
      theme: ThemeData(primaryColor: Colors.black)
    );
  }
}
