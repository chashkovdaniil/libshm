import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('О приложении'),
      ),
      body: Column(
        children: <Widget>[
          Text('Просто школьный дневник, только в электронном виде!')
        ],
      ),
    );
  }
}
