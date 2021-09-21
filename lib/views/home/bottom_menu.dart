import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/views/account/profile.dart';
import 'package:weezli/views/announce/announce_detail.dart';
import 'package:weezli/views/announce/create.dart';
import 'package:weezli/views/message/message_view.dart';
import 'package:weezli/views/home/home.dart';
import '../search/search.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Search(),
    CreateAnnounce(),
    MessageView(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(WeezlyIcon.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(WeezlyIcon.search), 
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(WeezlyIcon.notification),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(WeezlyIcon.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(WeezlyIcon.profil),
            label: 'Mon compte',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        iconSize: 35,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
