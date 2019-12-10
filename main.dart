import 'package:flutter/material.dart';
import 'package:schooldiary/Pages/Home/HomePage.dart';
import 'package:schooldiary/Pages/About/AboutPage.dart';
import 'package:schooldiary/Pages/Shedule/EditShedulePage.dart';
import 'package:schooldiary/Pages/Homework/EditHomeworkPage.dart';
import 'package:schooldiary/Pages/Subjects/SubjectsPage.dart';
import 'package:schooldiary/Pages/Settings/SettingsPage.dart';

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
        '/homework':(BuildContext context) => EditHomeworkPage(),
        '/settings':(BuildContext context) => SettingsPage()
      },
      theme: ThemeData(primaryColor: Colors.white)
    );
  }
}
