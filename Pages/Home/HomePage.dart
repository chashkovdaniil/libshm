import 'package:flutter/material.dart';
import 'package:hello_world/Pages/Panel/PanelPage.dart';
import '../../Shedule/sheduleTab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabIndex = 0;

  @override 
  Widget build(BuildContext context){
    final tabPages = <Widget>[
      Center(child: ShedulePage()),
      Center(child: PanelTab()),
    ];
    final bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Домашнее задание')),
      BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Панель')),
    ];
    assert(tabPages.length == bottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: tabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}