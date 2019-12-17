import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final List actions;
  const CustomAppBar({
    Key key,
    @required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0), 
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: AppBar(
          elevation: 0.0,
          title: Text(title,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            )
          ),
          actions: actions == null ? [] : actions.map<Widget>((item){
            return IconButton(
              icon: item['icon'],
              onPressed: (){
                Navigator.pushNamed(context, item['link']);
              },
            );
          }).toList(),
        ),
      )
    );
  }
}