import 'package:flutter/material.dart';
import 'package:schooldiary/Models/Shedule.dart';
import 'package:schooldiary/Models/Subject.dart';
import 'package:schooldiary/loadData.dart';
import './DialogLesson.dart';

class ShowShedule extends StatefulWidget {
  final int _weekday;
  ShowShedule(this._weekday);
  @override
  _ShowSheduleState createState() => _ShowSheduleState();
}

class _ShowSheduleState extends State<ShowShedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: FutureBuilder<Map<String, dynamic>>(
          future: DBProvider.db.getSheduleAndSubjects(widget._weekday),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData && (snapshot.data['shedule'].length > 0)) {
              List shedule = snapshot.data['shedule'];
              List _subjects = snapshot.data['subjects'];
              return ListView.builder(
                itemCount: shedule.length,
                itemBuilder: (BuildContext context, int index) {
                  Shedule item = shedule[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      DBProvider.db.deleteShedule(id: item.id, weekday: widget._weekday);
                      setState(() {});
                    },
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${item.id}')),
                      title: Text("${_subjects[item.subject-1]['title']}"),
                      onTap: (){
                        DialogLesson _editLesson = DialogLesson(
                          title: 'Редактировать',
                          buttonTitle: 'Сохранить',
                          id: item.id, 
                          weekday: widget._weekday, 
                          subject: Subject.fromMap(_subjects[item.subject-1]), 
                          query: DBProvider.db.updateShedule,
                        );
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => _editLesson
                        ).then((val){
                          setState(() {});
                        });
                      },
                    )
                  );
                }
              );
            } else {
              return Center(child: Text('Нет уроков'));
            }
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          DialogLesson _addLesson = DialogLesson(
            title: 'Добавить предмет',
            buttonTitle: 'Добавить',
            weekday: widget._weekday, 
            query: DBProvider.db.addShedule
          );
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => _addLesson
          ).then((val){
            setState((){});
          });
        },
      ),
    );
  }
}