import 'package:flutter/material.dart';
import 'package:schooldiary/Pages/Homework/HomeworkPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      // body: Text('1234'),
      body: HomeworkPage(),
    );
  }
}
