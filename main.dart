import 'package:flutter/material.dart';
import 'package:schooldiary/Pages/DonationPage/DontaionPage.dart';
import 'package:schooldiary/Pages/Grades/GradesPage.dart';
import 'package:schooldiary/Pages/Home/HomePage.dart';
import 'package:schooldiary/Pages/About/AboutPage.dart';
import 'package:schooldiary/Pages/Loader/LoaderPage.dart';
import 'package:schooldiary/Pages/NotDone/NotDonePage.dart';
import 'package:schooldiary/Pages/Shedule/ShedulePage.dart';
import 'package:schooldiary/Pages/Homework/EditHomeworkPage.dart';
import 'package:schooldiary/Pages/Subjects/SubjectsPage.dart';
import 'package:schooldiary/Pages/Settings/SettingsPage.dart';
import 'package:schooldiary/Pages/Update/UpdatePage.dart';

bool auth = true;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник',
      debugShowCheckedModeBanner: false,
      initialRoute: '/loader',
      routes: {
        '/':(BuildContext context) => HomePage(),
        '/about':(BuildContext context) => AboutPage(),
        '/subjects':(BuildContext context) => SubjectsPage(),
        '/editShedule':(BuildContext context) => EditShedulePage(),
        '/homework':(BuildContext context) => EditHomeworkPage(),
        '/notdone':(BuildContext context) => NotDonePage(),
        '/settings':(BuildContext context) => SettingsPage(),
        '/donation':(BuildContext context) => DonationPage(),
        '/grades':(BuildContext context) => GradesPage(),
        '/loader':(BuildContext context) => LoaderPage(),
        '/update':(context) => UpdatePage()
      },
      theme: ThemeData(primaryColor: Colors.white)
    );
  }
}
