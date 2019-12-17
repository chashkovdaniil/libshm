import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoaderPage extends StatefulWidget {
  @override
  _LoaderPageState createState() => _LoaderPageState();
}
class _LoaderPageState extends State<LoaderPage>{
  Future checkFirstStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstStart') ?? true;
  }
  
  @override
  void initState() {
    super.initState();
      Timer(Duration(seconds: 3), (){
        checkFirstStart().then( (value) {
          if (value) {
            return Navigator.of(context).pushReplacementNamed('/update');
          }
          return Navigator.of(context).pop();// pushReplacementNamed('/');
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset("res/images/ic_launcher.png"),));
  }
}