import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schooldiary/Pages/Homework/HomeworkPageArgs.dart';
import 'package:schooldiary/loadData.dart';

class EditHomeworkPage extends StatefulWidget {
  @override
  EditHomeworkPageState createState() => EditHomeworkPageState();
}

class EditHomeworkPageState extends State<EditHomeworkPage> {
  bool isDone = false;
  Widget floatingActionButton(HomeworkPageArgs args) {
    return FloatingActionButton(
      child: Icon(Icons.done),
      onPressed: (){
        print('id = ${args.idShedule}');
        args.homework.idShedule = args.idShedule;
        args.homework.subject = args.idSubject;
        args.homework.date = args.date;
        
        print(args.homework.toMap());
        DBProvider.db.homework(
          homework: args.homework);
        Navigator.pop(context);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final HomeworkPageArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        elevation: 0.0,
      ),
      body: Form(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.deepOrange.withOpacity(0.7)),
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        initialValue: '${args.homework.grade == null ? "" : args.homework.grade}',
                        maxLength: 1,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Оценка: "
                        ),
                        onChanged: (value){
                          setState(() {
                            args.homework.grade = value == "" ? null : int.parse(value);
                          });
                        }
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text('Сделано?'),
                          Checkbox(
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            value: args.homework.isDone,
                            onChanged: (val){
                              setState(() {
                                args.homework.isDone = val;
                              });
                            }
                          )
                        ]
                      )
                    )
                  ],
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
        )
      ),
      floatingActionButton: floatingActionButton(args)
    );
  }
}