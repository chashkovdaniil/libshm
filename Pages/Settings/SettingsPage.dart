import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final List<Map> list = <Map>[
    {'title': 'Расписание', 'icon': Icon(Icons.list), 'url': '/editShedule'},
    {'title': 'Предметы', 'icon': Icon(Icons.filter_list), 'url': '/subjects'},
    {'title': 'О приложении', 'icon': Icon(Icons.info), 'url': '/about'}
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("настройки"),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
          
        ),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.w300
          )
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: list.length,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50.0),
                // leading: list[position]['icon'],
                title: Text('${list[position]['title']}', style: TextStyle(fontWeight: FontWeight.w300),),
                onTap: () {
                  Navigator.pushNamed(context, list[position]['url']);
                },
            );
          }
        ),
      )
    );
  }
}
