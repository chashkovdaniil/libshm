import 'package:flutter/material.dart';
import 'package:schooldiary/Models/Subject.dart';
import 'package:schooldiary/Modules/AppBar.dart';
import 'package:schooldiary/loadData.dart';

List monthString = ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Авгутс', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'];

class GradesPage extends StatefulWidget{
  @override
  _GradesPageState createState() => _GradesPageState();
}
class _GradesPageState extends State<GradesPage>{
  DateTime _date;

  @override
  void initState() {
    _date = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Оценки',
      ),
      body: Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: () {
                      setState(() {
                        _date = _date.subtract(Duration(days: 31));
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(child: Text(monthString[_date.month-1], style: TextStyle(fontSize: 20.0),)),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: () {
                      setState(() {
                        _date = _date.add(Duration(days: 31));
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(child: FutureBuilder(
            future: DBProvider.db.getSubjects(),
            builder: (context, snapshot){
              if (snapshot.hasData && snapshot.data.length > 0) {
                List subjects = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    Subject subject = subjects[index];
                    return ListTile(
                      title: Text(subject.title),
                      subtitle: FutureBuilder(
                        future: DBProvider.db.getGrades(subject.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            String grades = '';

                            snapshot.data.forEach( (item) {
                              if ('${item.date}'.indexOf('${_date.month}${_date.year}') != -1){
                                if (item.grade != null) {
                                  grades = '$grades ${item.grade}';
                                }
                              }
                            });
                            return grades == '' ? Text('Оценок нет') : Text(grades);
                          }
                          return Text('Оценок нет');
                        }
                      ),
                    );
                  }
                );
              }
              return Center(child: Text('Добавьте предметы'));
            },
          ))
        ]),
      ),
    );
  }
}