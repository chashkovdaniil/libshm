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
        child: FutureBuilder<List<Shedule>>(
          future: DBProvider.db.getShedule(weekday: widget._weekday),
          builder: (BuildContext context, AsyncSnapshot<List<Shedule>> snapshot) {
            if (snapshot.hasData && (snapshot.data.length > 0)) {
              List shedule = snapshot.data;
              return ListView.builder(
                itemCount: shedule.length,
                itemBuilder: (BuildContext context, int index) {
                  Shedule item = shedule[index];
                  return FutureBuilder<List<Subject>>(
                    future: DBProvider.db.getSubject(item.subject),
                    builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshotSubject){
                      if(snapshotSubject.hasData){
                        Subject subject = snapshotSubject.data[0];
                        return ListTile(
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              var raw = await DBProvider.db.deleteShedule(id: item.id, weekday: widget._weekday);
                              if (raw['done'] == 1){
                                setState(() {});
                              }
                            }
                          ),
                          title: Text("${subject == null ? "" : subject.title}", style: TextStyle(fontSize: 20.0),),
                          onTap: (){
                            DialogLesson _editLesson = DialogLesson(
                              title: 'Редактировать',
                              buttonTitle: 'Сохранить',
                              id: item.id, 
                              weekday: widget._weekday, 
                              subject: subject, 
                              query: DBProvider.db.updateShedule,
                            );
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => _editLesson
                            ).then((val){
                              setState(() {});
                            });
                          },
                        );
                      }else{
                        return CircularProgressIndicator();
                      }
                      
                    },
                  );
                  // return Dismissible(
                  //   key: UniqueKey(),
                  //   background: Container(color: Colors.red),
                  //   onDismissed: (direction) async {
                  //     var raw = await DBProvider.db.deleteShedule(id: item.id, weekday: widget._weekday);
                  //     if (raw['done'] == 1){
                  //       setState(() {});
                  //     }
                  //   },
                  //   child: ListTile(
                  //     title: Text("${_subjects[item.subject-1]['title']}", style: TextStyle(fontSize: 20.0),),
                  //     onTap: (){
                  //       DialogLesson _editLesson = DialogLesson(
                  //         title: 'Редактировать',
                  //         buttonTitle: 'Сохранить',
                  //         id: item.id, 
                  //         weekday: widget._weekday, 
                  //         subject: Subject.fromMap(_subjects[item.subject-1]), 
                  //         query: DBProvider.db.updateShedule,
                  //       );
                  //       showDialog<String>(
                  //         context: context,
                  //         builder: (BuildContext context) => _editLesson
                  //       ).then((val){
                  //         setState(() {});
                  //       });
                  //     },
                  //   )
                  // );
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
        onPressed: () async{
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