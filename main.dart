import 'package:flutter/material.dart';
import './home.dart';
import './about.dart';
import './subjects.dart';
import './Shedule/editShedule.dart';
import './Pages/HomeworkPage.dart';

bool auth = true;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
