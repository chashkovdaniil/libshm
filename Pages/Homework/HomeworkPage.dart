import 'package:flutter/material.dart';
import 'package:schooldiary/Models/Homework.dart';
import 'package:schooldiary/Models/Shedule.dart';
import 'package:schooldiary/Pages/Homework/HomeworkPageArgs.dart';
import 'package:schooldiary/loadData.dart';

class ShedulePage extends StatefulWidget {
  @override
  _ShedulePageState createState() => _ShedulePageState();
}
class _ShedulePageState extends State<ShedulePage> {
  DateTime _date;
  int _day;
  int _weekday;
  int _month;
  int _year;
  @override
  void initState() {
    _date = DateTime.now();
    _day = _date.day;
    _weekday = _date.weekday;
    _month = _date.month;
    _year = _date.year;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    String _dayString = "Понедельник";

    switch (_weekday) {
      case 1:{
        _dayString = 'Понедельник';
      }
      break;
      case 2:{
        _dayString = 'Вторник';
      }
      break;
      case 3:{
        _dayString = 'Среда';
      }
      break;
      case 4:{
        _dayString = 'Четверг';
      }
      break;
      case 5:{
        _dayString = 'Пятница';
      }
      break;
      case 6:{
        _dayString = 'Суббота';
      }
      break;
      case 7:{
        _dayString = 'Воскресенье';
      }
      break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 11,
            child: FutureBuilder<Map<String, dynamic>>(
              future: DBProvider.db.getSSH(weekday: _date.weekday, date: int.parse('${_date.day}${_date.month}${_date.year}')),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData && (snapshot.data['shedule'].length > 0)) {
                  List shedule = snapshot.data['shedule'];
                  List subjects = snapshot.data['subjects'];
                  List homeworks = snapshot.data['homeworks'];
                  return ListView.builder(
                    itemCount: shedule.length,
                    itemBuilder: (BuildContext context, int index) {
                      Homework currentHomework;
                      Shedule item = shedule[index];
                      homeworks.forEach((hm){
                        if (hm.subject == subjects[item.subject-1]['id']) {
                          currentHomework = hm;
                        }
                      });
                      return ListTile(
                        leading: CircleAvatar(child: Text('${item.id}')),
                        title: Text('${subjects[item.subject-1]['title']}'),
                        subtitle: Text('${currentHomework != null ? currentHomework.content : ""}'),
                        trailing: CircleAvatar(
                          child: Text(
                            '${currentHomework != null ? currentHomework.grade : ""}', 
                            style: TextStyle(color: Colors.white)
                          ), 
                          backgroundColor: Colors.redAccent),
                        onTap: () {
                          Navigator.pushNamed(context, '/homework', arguments: HomeworkPageArgs(
                            title: subjects[item.subject-1]['title'], 
                            content: currentHomework != null ? currentHomework.content : "",
                            homework: currentHomework != null ? currentHomework : null,
                            grade: currentHomework != null ? currentHomework.grade : null,
                            idSubject: subjects[item.subject-1]['id'], 
                            date: int.parse('${_date.day}${_date.month}${_date.year}')
                          ));
                        },
                      );
                    }
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ),
          Expanded(
            flex: 1,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              FlatButton(child: Icon(Icons.arrow_back), onPressed: (){
                setState(() {
                  _date = _date.subtract(Duration(days: 1));
                  _day = _date.day;
                  _weekday = _date.weekday;
                  _month = _date.month;
                  _year = _date.year;
                });
              }),
              SizedBox(width: 10.0),
              Expanded(
                child: Center(child:Text('$_dayString ($_day)', style: TextStyle(fontSize: 20.0))),
              ),
              SizedBox(width: 10.0),
              FlatButton(child: Icon(Icons.arrow_forward), onPressed: (){
                setState(() {
                  _date = _date.add(Duration(days: 1));
                  _day = _date.day;
                  _weekday = _date.weekday;
                  _month = _date.month;
                  _year = _date.year;
                });
              }),
            ],)
          )
        ],
      )
    );
  }
}