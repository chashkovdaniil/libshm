import 'package:flutter/material.dart';
import 'package:schooldiary/Models/Homework.dart';
import 'package:schooldiary/Models/Subject.dart';
import 'package:schooldiary/Modules/AppBar.dart';
import 'package:schooldiary/Pages/Homework/HomeworkPageArgs.dart';
import 'package:schooldiary/loadData.dart';

class NotDonePage extends StatefulWidget {
  @override
  _NotDonePageState createState() => _NotDonePageState();
}
class _NotDonePageState extends State<NotDonePage> {

  Widget widgetHomework({homeworks, homework, index}) {
    return FutureBuilder<List<Subject>>(
      future: DBProvider.db.getSubject(homework.subject),
      builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
        if(snapshot.hasData){
          Subject subject = snapshot.data[0];
          Widget isDone() {
            if (homework.id != null ) {
              return Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Checkbox(
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    value: homework.isDone,
                    onChanged: (val){
                      setState(() {
                        homework.isDone = val;
                        DBProvider.db.homework(homework: homework);
                      });
                    },
                  )
                )
              );
            }
            return Expanded(flex: 1, child: SizedBox());
          }
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/homework', arguments: HomeworkPageArgs(
                title: subject.title, 
                homework: homework
              ));
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.deepOrange.withOpacity(0.7)),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          Text('${subject.title}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w900
                          )),
                          SizedBox(height: 10.0),
                          Text('${homework.content != null ? homework.content : ""}')
                        ],
                      )
                    )
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                      children: <Widget>[
                        Text('${homework.grade != null ? homework.grade : ""}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900
                          ))
                      ],
                    )
                    )
                  ),
                  isDone()
                ]
              )
            )
          );
        }else{
          return Text('');
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Не сделано', actions: [
        {'icon':Icon(Icons.attach_money), 'link': '/donation'},
        {'icon':Icon(Icons.settings), 'link': '/settings'}
      ]),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 11,
            child: Container(color: Colors.white, child: FutureBuilder<List<Homework>>(
              future: DBProvider.db.getNotDoneHomeworks(),
              builder: (BuildContext context, AsyncSnapshot<List<Homework>> snapshot) {
                if (snapshot.hasData && (snapshot.data.length > 0)) {
                  List homeworks = snapshot.data;

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: homeworks.length,
                    itemBuilder: (BuildContext context, int index) {
                      Homework homework = homeworks[index];
                      return widgetHomework(index: index, homeworks: homeworks, homework: homework);
                    }
                  );
                } else {
                  return Center(child: Text('У вас всё сделано!'));
                }
              },
            ))
          ),
        ],
      )
    );
  }
}