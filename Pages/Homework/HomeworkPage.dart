import 'package:flutter/material.dart';
import 'package:schooldiary/Models/Homework.dart';
import 'package:schooldiary/Models/Shedule.dart';
import 'package:schooldiary/Pages/Homework/HomeworkPageArgs.dart';
import 'package:schooldiary/loadData.dart';

class HomeworkPage extends StatefulWidget {
  @override
  _HomeworkPageState createState() => _HomeworkPageState();
}
class _HomeworkPageState extends State<HomeworkPage> {
  DateTime _date;
  int _day;
  int _weekday;
  @override
  void initState() {
    _date = DateTime.now();
    _day = _date.day;
    _weekday = _date.weekday;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List _dayString = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0), 
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        )
      ),
      body: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(
              width: double.infinity,
              height: 80,
            ),
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 11,
                      child: Text('расписание',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: (){
                          Navigator.pushNamed(context, '/settings');
                        },
                      )
                    )
                  ],
                )
              )
            ),
          Expanded(
            flex: 11,
            child: Container(color: Colors.white, child: FutureBuilder<Map<String, dynamic>>(
              future: DBProvider.db.getSSH(weekday: _date.weekday, date: int.parse('${_date.day}${_date.month}${_date.year}')),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData && (snapshot.data['shedule'].length > 0)) {
                  List shedule = snapshot.data['shedule'];
                  List subjects = snapshot.data['subjects'];
                  List homeworks = snapshot.data['homeworks'];
                  
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: shedule.length,
                    itemBuilder: (BuildContext context, int index) {
                      Homework currentHomework = Homework.fromMap({});
                      Shedule item = shedule[index];

                      homeworks.forEach((hm){
                        if (hm.subject == subjects[item.subject-1]['id']) {
                          currentHomework = hm;
                        }
                      });
                      
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/homework', arguments: HomeworkPageArgs(
                            title: subjects[item.subject-1]['title'], 
                            content: currentHomework.content,
                            homework: currentHomework,
                            grade: currentHomework.grade,
                            idSubject: subjects[item.subject-1]['id'], 
                            date: int.parse('${_date.day}${_date.month}${_date.year}'),
                            isDone: currentHomework.isDone
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
                                  child: Text('${item.id}', style: TextStyle(
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
                                      Text('${subjects[item.subject-1]['title']}', style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.w900
                                      )),
                                      SizedBox(height: 10.0),
                                      Text('${currentHomework.content != null ? currentHomework.content : ""}')
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
                                    // Text('Оценка:', style: TextStyle(
                                    //   color: Colors.white,
                                    //   fontSize: 15.0,
                                    //   fontWeight: FontWeight.w900
                                    // )),
                                    // SizedBox(height: 10.0),
                                    Text('${currentHomework.grade != null ? currentHomework.grade : ""}', style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900
                                      ))
                                  ],
                                )
                                )
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    value: currentHomework.isDone,
                                    onChanged: (val){
                                      setState(() {
                                        currentHomework.isDone = val;
                                        DBProvider.db.homework(homework: currentHomework);
                                      });
                                    },
                                  )
                                )
                              )
                            ]
                          )
                        )
                      );
                    }
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
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
                      _day = _date.day;
                      _weekday = _date.weekday;
                    });
                  }),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 5,
                  child: Center(child:Text('${_dayString[_weekday-1]} ($_day)', style: TextStyle(fontSize: 20.0))),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: FlatButton(child: Icon(Icons.arrow_forward), onPressed: (){
                    setState(() {
                      _date = _date.add(Duration(days: 1));
                      _day = _date.day;
                      _weekday = _date.weekday;
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