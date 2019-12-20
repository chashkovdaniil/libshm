import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage>{
  final List<Map> list = <Map>[
    {'title': 'Все оценки', 'icon': Icon(Icons.grade), 'url': '/grades'},
    {'title': 'Расписание', 'icon': Icon(Icons.list), 'url': '/editShedule'},
    {'title': 'Предметы', 'icon': Icon(Icons.filter_list), 'url': '/subjects'},
    {'title': 'О приложении', 'icon': Icon(Icons.info), 'url': '/about'}
  ];

  reminderTime({bool val}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool remind = prefs.getBool('remindToPack') ?? false;

    if (val == null) {
      return remind;
    }

    prefs.setBool('remindToPack', val);
  }

  remindToPack({bool val}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool remind = prefs.getBool('remindToPack') ?? false;

    if (val == null) {
      return remind;
    }

    prefs.setBool('remindToPack', val);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки"),
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
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: remindToPack(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 50.0),
                    title: Text('Напоминать, что стоит собрать рюкзак?'),
                    trailing: Checkbox(
                      value: snapshot.data,
                      onChanged: (val) async{
                        await remindToPack(val: val);
                        setState((){});
                      },
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Expanded(child:
              ListView.builder(
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
            )),
          ]
        )
      )
    );
  }
}
