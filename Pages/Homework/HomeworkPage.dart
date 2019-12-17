import 'package:flutter/material.dart';
import 'package:schooldiary/Models/Homework.dart';
import 'package:schooldiary/Models/Shedule.dart';
import 'package:schooldiary/Models/Subject.dart';
import 'package:schooldiary/Modules/AppBar.dart';
import 'package:schooldiary/Pages/Homework/HomeworkPageArgs.dart';
import 'package:schooldiary/loadData.dart';

class HomeworkPage extends StatefulWidget {
  @override
  _HomeworkPageState createState() => _HomeworkPageState();
}
class _HomeworkPageState extends State<HomeworkPage> {
  DateTime _date;
  
  Widget widgetHomework({homeworks, homework, shedule, index}) {
    return FutureBuilder<List<Subject>>(
      future: DBProvider.db.getSubject(shedule.subject),
      builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
        if (snapshot.hasData) {
          Subject subject = snapshot.data[0];
          homeworks.forEach((hm){
            if (hm.subject == subject.id && hm.idShedule == shedule.id) {
              homework = hm;
            }
          });
          Widget isDone() {
            if (homework.id != null && homework.content != "" && homework.content != null) {
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
              homework.idShedule = shedule.id;
              homework.subject = subject.id;
              homework.date = int.parse('${_date.day}${_date.month}${_date.year}');
              Navigator.pushNamed(context, '/homework', arguments: HomeworkPageArgs(
                title: subject.title, 
                homework: homework,
              ));
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.deepOrange.withOpacity(0.7)),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text('${index+1}', style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900
                      )),
                    )
                  ),
                  SizedBox(width: 20.0),
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
  void initState() {
    _date = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List _dayString = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];

    return Scaffold(
      appBar: CustomAppBar(title: 'Расписание', actions: [
        {'icon':Icon(Icons.attach_money), 'link': '/donation'},
        {'icon':Icon(Icons.check_circle), 'link': '/notdone'},
        {'icon':Icon(Icons.settings), 'link': '/settings'}
      ]),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 11,
            child: Container(color: Colors.white, child: FutureBuilder<Map<String, dynamic>>(
              future: DBProvider.db.getSH(weekday: _date.weekday, date: int.parse('${_date.day}${_date.month}${_date.year}')),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData && (snapshot.data['shedule'].length > 0)) {
                  List shedule = snapshot.data['shedule'];
                  List homeworks = snapshot.data['homeworks'];
                  
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: shedule.length,
                    itemBuilder: (BuildContext context, int index) {
                      Homework currentHomework = Homework.fromMap({});
                      Shedule item = shedule[index];
                      
                      return widgetHomework(index: index, homeworks: homeworks, homework: currentHomework, shedule: item);
                  });
                }
                return Center(child: Text('Заполните расписание'));
              },
            ))
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                Expanded(
                  flex: 2,
                  child: FlatButton(child: Icon(Icons.arrow_back), onPressed: (){
                    setState(() {
                      _date = _date.subtract(Duration(days: 1));
                    });
                  }),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 5,
                  child: Center(child:Text('${_dayString[_date.weekday-1]} (${_date.day})', style: TextStyle(fontSize: 20.0))),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: FlatButton(child: Icon(Icons.arrow_forward), onPressed: (){
                    setState(() {
                      _date = _date.add(Duration(days: 1));
                    });
                  })
                )
              ],)
            )
          )
        ],
      )
    );
  }
}