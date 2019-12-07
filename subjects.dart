import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './Models/Subject.dart';
import './loadData.dart';

class SubjectsPage extends StatefulWidget {
  @override

  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  final _editFormKey = GlobalKey<FormState>();
  final _newFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Список предметов')),
      body: FutureBuilder<List<Subject>>(
        future: DBProvider.db.getSubjects(),
        builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshot){
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                Subject item = snapshot.data[index];

                String changedTitle = item.title;
                String changedTeacher = item.teacher;

                print(item.title);
                print(item.teacher);
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteSubject(item.id);
                  },
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.teacher),
                    onTap: (){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => SimpleDialog(
                          title: Text('Редактирование'),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Form(
                                key: _editFormKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Название'
                                      ),
                                      onChanged: (val){
                                        changedTitle = val;
                                      },
                                      validator: (value) => value.isEmpty ? 'Заполните поле!' : null,
                                      initialValue: item.title,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'ФИО учителя'
                                      ),
                                      onChanged: (val){
                                        changedTeacher = val;
                                      },
                                      initialValue: item.teacher,
                                    ),
                                    FlatButton(child: Text("OK"), onPressed: (){
                                      if (_editFormKey.currentState.validate()) {
                                        Navigator.pop(context, 'OK');
                                      }
                                    })
                                  ],
                                )
                              )
                            )
                          ],
                        )
                      ).then((value){
                        if (changedTitle.isEmpty) {  
                          Fluttertoast.showToast(msg: 'Укажите название!');
                        } else {
                          Fluttertoast.showToast(msg: 'Сохранено!');
                          Subject subject = Subject(id: item.id, title: changedTitle, teacher: changedTeacher);
                          DBProvider.db.updateSubject(subject);
                        }
                      });
                    }
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          String title;
          String teacher = "";
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => SimpleDialog(
              title: Text('Новый предмет'),
              children:  <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _newFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Название'
                          ),
                          onChanged: (val){
                            title = val;
                          },
                          validator: (value) => value.isEmpty ? 'Заполните поле!' : null,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'ФИО учителя'
                          ),
                          onChanged: (val){
                            teacher = val;
                          }
                        ),
                        FlatButton(child: Text("OK"), onPressed: (){
                          if (_newFormKey.currentState.validate()) {
                            Navigator.pop(context, 'OK');
                          }
                        })
                      ],
                    )
                  )
                )
              ]
            )
          ).then((data) {
            if (title.isEmpty) { 
              Fluttertoast.showToast(msg: 'Укажите название!');
            } else {
              Fluttertoast.showToast(msg: 'Добавлено!');
              Subject subject = Subject(title: title, teacher: teacher);
              DBProvider.db.addSubject(subject);
            }
          });
        },
      ),
    );
  }
}