import 'package:flutter/material.dart';
import 'package:schooldiary/Pages/Homework/HomeworkPageArgs.dart';
import 'package:schooldiary/loadData.dart';

class EditHomeworkPage extends StatefulWidget {
  @override
  EditHomeworkPageState createState() => EditHomeworkPageState();
}

class EditHomeworkPageState extends State<EditHomeworkPage> {
  @override
  Widget build(BuildContext context) {
    final HomeworkPageArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Form(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Оценка: "
                  ),
                  onChanged: (value){
                    setState(() {
                      args.homework.grade = value == "" ? null : int.parse(value);
                    });
                  },
                  initialValue: '${args.homework.grade == null ? "" : args.homework.grade}',
                ),
                SizedBox(height: 24.0),
                Expanded(
                  child: TextFormField(  
                    onChanged: (value){
                      setState(() {
                        args.homework.content = value;
                        print(value);
                      });
                    },
                    maxLines: 20,
                    initialValue: args.content,
                    decoration: InputDecoration(
                      labelText: "Задали: ",
                    ),
                    style: TextStyle(fontSize: 20.0),
                  )
                )
              ]
            )
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: (){
          args.homework.subject = args.idSubject;
          args.homework.date = args.date;
          
          print(args.homework.toMap());
          DBProvider.db.homework(
            homework: args.homework);
          Navigator.pop(context);
        },
      ),
    );
  }
}