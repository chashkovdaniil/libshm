import 'package:flutter/material.dart';
import 'package:schooldiary/Pages/Shedule/SheduleDayPage.dart';

class EditShedulePage extends StatefulWidget { 
  @override
  _EditShedulePageState createState() => _EditShedulePageState();
}
class _EditShedulePageState extends State<EditShedulePage> with SingleTickerProviderStateMixin {
  // String _selectedSubject = 'Выберите предмет';
  TabController _tabController;
  int count = 0;
  // final _addFormKey = GlobalKey<FormState>();
  var tabPages = <Widget>[
    ShowShedule(1),
    ShowShedule(2),
    ShowShedule(3),
    ShowShedule(4),
    ShowShedule(5),
    ShowShedule(6),
    ShowShedule(7),
  ];
  static const tabs = <Tab>[
    Tab(text: 'Пн'),
    Tab(text: 'Вт'),
    Tab(text: 'Ср'),
    Tab(text: 'Чт'),
    Tab(text: 'Пт'),
    Tab(text: 'Сб'),
    Tab(text: 'Вс'),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: DateTime.now().weekday-1,
      length: tabPages.length, 
      vsync: this
    );
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание'),
        elevation: 0.0,
      ),
      body: TabBarView(
        children: tabPages,
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          tabs: tabs,
          controller: _tabController,
        )
      )
    );
  }
}