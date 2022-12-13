import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

class Loding extends StatefulWidget {
  const Loding({Key? key}) : super(key: key);
  @override
  _LodingState createState() => _LodingState();
}

class _LodingState extends State<Loding> {
  int _selectedIndex = 0;
  int pageIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Menu',
      style: optionStyle,
    ),
    Text(
      'Index 1: 알림',
      style: optionStyle,
    ),
    Text(
      'Index 2: My page',
      style: optionStyle,
    ),
  ];
  List<Widget> _demo = [
    Container(height: 300, color: Colors.amber),
    Container(height: 300, color: Colors.black),
    Container(height: 300, color: Colors.blue),
    Container(height: 300, color: Colors.green),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    @override
    void initState() {
      super.initState();
      getLocation();
      fetchData();
    }
  }

  void getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
    } on Exception catch (e) {
      print('there are some problem');
    }
  }

  void fetchData() async {
    http.Response response = await http.get(Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    print(response.body);
    print(response.statusCode);
  }

  //final device = Container(
  //  width: 100,
  //  height: 100,
  //  child: Text('기기등록'),
  //  color: Color(0xff1160aa),
  //);

  final weather = Padding(
    padding: EdgeInsets.all(20.0),
    child: Material(
      borderRadius: BorderRadius.circular(80.0),
      shadowColor: Colors.lightBlueAccent.shade100,
      elevation: 10.0,
      child: MaterialButton(
        minWidth: 200.0,
        height: 48.0,
        onPressed: () {},
        color: Color(0xff1160aa),
        child: Text('내 위치', style: TextStyle(color: Colors.white)),
      ),
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff1160aa)), //보류 (필요없을거같음)
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              CarouselIndicator(
                count: _demo.length,
                index: pageIndex,
              ),
              Text(
                  textAlign: TextAlign.center,
                  '우리집 수호천사',
                  style: TextStyle(
                      color: Color(0xff1160aa),
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 24,
              ),
              weather,
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  print('기기등록');
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: PageView(
                    children: _demo,
                    onPageChanged: (index) {
                      setState(() {
                        pageIndex = index;
                      });
                    },
                  ),
                ),
              )
              //Container(
              //  height: 200,
              //  width: double.infinity,
              //  child: PageView(
              //    children: _demo,
              //    onPageChanged: (index) {
              //      setState(() {
              //        pageIndex = index;
              //      });
              //    },
              //  ),
              //),
              //CarouselIndicator(
              //  count: _demo.length,
              //  index: pageIndex,
              //  color: Color(0xff1160aa),
              //),
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My page',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff1160aa),
        onTap: _onItemTapped,
      ),
    );
  }
}
