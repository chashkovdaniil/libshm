import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('О приложении'),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset("res/images/ic_launcher.png"),
              SizedBox(height: 20.0),
              Text('SchoolDiary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              SizedBox(height: 20.0),
              Text('Просто школьный дневник, только в электронном виде!')
            ]
          )
        )
      ),
    );
  }
}
