import 'package:flutter/material.dart';
import 'package:schooldiary/Modules/AppBar.dart';
class DonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(title: 'Помощь разработчику'),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SelectableText(
              'Если Вы хотите поддержать проект, то буду рад любому рублю, все реквизиты ниже:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            SelectableText(
              'QIWI: +79080003428',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            SelectableText(
              'Номер карты (VISA): 4276320013682639',
              style: TextStyle(fontSize: 20.0),
            )
          ]
        ),
      )
    );
  }
}