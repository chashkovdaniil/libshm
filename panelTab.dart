import 'package:flutter/material.dart';

class PanelTab extends StatelessWidget {
  final List<Map> list = <Map>[
    {'title': 'Расписание', 'icon': Icon(Icons.list), 'url': '/editShedule'},
    {'title': 'Предметы', 'icon': Icon(Icons.filter_list), 'url': '/subjects'},
    {'title': 'О приложении', 'icon': Icon(Icons.info), 'url': '/about'}
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Панель")
      ),
      body: Container(
        child: ListView.builder(
          itemCount: list.length,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return ListTile(
                leading: list[position]['icon'],
                title: Text('${list[position]['title']}'),
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
