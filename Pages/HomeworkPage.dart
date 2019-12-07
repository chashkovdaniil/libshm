import 'package:flutter/material.dart';
import 'package:hello_world/Pages/HomeworkPageArgs.dart';
import 'package:hello_world/loadData.dart';
import 'package:hello_world/Models/Homework.dart';

class HomeworkPage extends StatefulWidget {
  @override
  HomeworkPageState createState() => HomeworkPageState();
}

class HomeworkPageState extends State<HomeworkPage> {
  String content;
  int grade;
  @override
  Widget build(BuildContext context) {
    final HomeworkPageArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (value){
                      setState(() {
                        grade = int.parse(value);
                      });
                    },
                    initialValue: '${args.grade}',
                  ),
                  TextFormField(  
                    onChanged: (value){
                      setState(() {
                        content = value;
                      });
                    },
                    maxLines: 20,
                    initialValue: args.content,
                    decoration: InputDecoration(
                      hintText: "Что задали?",
                    ),
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: (){
          Homework homework;
          if (args.homework == null) {
            homework = Homework.fromMap({
              'subject': args.idSubject,
              'date': args.date,
              'content': content == null ? "" : content,
              'grade': grade == null ? "" : grade
            });
            print('1-${homework.toMap()}');
          } else {
            args.homework.content = content == null ? (args.content != null ? args.content : "") : content;
            args.homework.grade = grade == null ? (args.grade != null ? args.grade : "") : grade;
            homework = args.homework;
            print('2-${homework.toMap()}');
          }
          DBProvider.db.homework(
            homework: homework,
            idSubject: args.idSubject, 
            content: content,
            date: args.date);
          Navigator.pop(context);
        },
      ),
    );
  }
}