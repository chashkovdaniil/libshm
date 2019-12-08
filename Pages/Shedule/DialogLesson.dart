import 'package:flutter/material.dart';
import 'package:hello_world/Models/Subject.dart';
import 'package:hello_world/Models/Shedule.dart';
import 'package:hello_world/loadData.dart';

class DialogLesson extends StatefulWidget{
  final int weekday;
  final int id;
  final Function query;
  final Subject subject;
  final String title;
  final String buttonTitle;

  DialogLesson({
    this.weekday, 
    this.id, 
    this.query, 
    this.subject,
    this.title,
    this.buttonTitle
  });

  @override
  _DialogLessonState createState() => _DialogLessonState();
}
class _DialogLessonState extends State<DialogLesson>{
  final _lessonFormKey = GlobalKey<FormState>();
  Subject selectedSubject;
  Future<List<Subject>> _subjects;
  @override
  void initState(){
    _subjects = DBProvider.db.getSubjects();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(title: Text(widget.title),children: <Widget>[
      Form(
        key: _lessonFormKey,
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Subject>>(
              future: _subjects,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton<Subject>(
                    value: (selectedSubject == null && widget.subject != null) ? snapshot.data[widget.subject.id-1] : selectedSubject,
                    items: snapshot.data.map((value) {
                      return  DropdownMenuItem<Subject>(
                        value: value,
                        child: Text(value.title),
                      );
                    }).toList(),
                    hint: Text("Выберите предмет"),
                    onChanged: (Subject chosenSubject) {
                      setState(() {
                        selectedSubject = chosenSubject;
                      });
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }
            ),
            FlatButton(
              child: Text(widget.buttonTitle),
              onPressed: () async {
                int lastId;
                List lastShedule;
                if( widget.subject == null ){
                  lastShedule = await DBProvider.db.getMaxId(weekday: widget.weekday);
                  lastId = lastShedule.length == 0 ? 1 : lastShedule[0].id;
                }
                widget.query(
                  weekday: widget.weekday, 
                  shedule: Shedule.fromMap({
                    'id': widget.id == null ? lastId : widget.id,
                    'subject': selectedSubject.id,
                }));
                Navigator.pop(context, 'true');
              },
            )
          ],
        ),
      )
    ]);
  }

}