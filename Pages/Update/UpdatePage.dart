import 'package:flutter/material.dart';
import 'package:schooldiary/loadData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePage extends StatefulWidget {
  @override
  UpdatePageState createState() => UpdatePageState();
}
class UpdatePageState extends State<UpdatePage> {
  bool isFirstStart = true;
  
  Future checkFirstStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isFirstStart = prefs.getBool('isFirstStart') ?? true;
    if (_isFirstStart) {
      DBProvider.db.updateBase();
      prefs.setBool('isFirstStart', false);
    }
  }

  @override
  void initState() {
    checkFirstStart().then( (value) => Navigator.of(context).pop()); //pushReplacementNamed('/'));
    super.initState();
  }

  @override
  Widget build(context){
    return Scaffold(
      body: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
        isFirstStart ? Text('Обновляемся') : Text('Закончено')
      ])),
    );
  }
}