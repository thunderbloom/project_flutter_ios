import 'package:flutter/material.dart';
import 'package:project_flutter/pages/device_page.dart';
import 'package:project_flutter/pages/signup.dart';
void main() {
  runApp(MaterialApp(
    title: 'Main page',
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class  _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    Sign_up(),
    DevicePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '우리집',
          style: TextStyle(color: Colors.blue, fontFamily: 'summer')),
          backgroundColor: Colors.white,
      ),

      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'my page',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: _onItemTapped,
        
      ),
    );
  }
}

