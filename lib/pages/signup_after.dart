import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_flutter/main.dart';
import 'package:project_flutter/pages/login_page.dart';
import 'package:project_flutter/pages/main_page.dart';
import 'package:project_flutter/pages/sign_up.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Signup_after());

class Signup_after extends StatefulWidget {
  const Signup_after({Key? key}) : super(key: key);
  @override
  _Signup_afterState createState() => _Signup_afterState();
}

class _Signup_afterState extends State<Signup_after> {
  String _id = '';
  @override
  void initState() {
    super.initState();
    // _readData();
  }

  // Future<String> _readData() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String dd = 's';
  //   final _id = _prefs.getString('ID') ?? '';
  //   final _pw = _prefs.getString('Password') ?? '';
  //   final _name = _prefs.getString('Name') ?? '';
  //   final _phone = _prefs.getString('Phone_Number') ?? '';
  //   final _address = _prefs.getString('Address') ?? '';
  //   final _email = _prefs.getString('Email') ?? '';

  //   _prefs.getKeys();

  //   return dd;
  // }

  @override
  Widget build(BuildContext context) {
    // var id = _id;
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: FloatingActionButton(
                child: Icon(Icons.account_box),
                onPressed: () {
                  // _readData();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            'save',
                            // '저장: $_readData',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        );
                      });
                  Text('아이디 : $_id');
                },
              ),
            )

            // Center(
            //   child: Image.asset(
            //     'assets/images/temp_logo.jpg', // png 바꾸기
            //     width: 150.0,
            //     height: 150.0,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
            //   child: Text(
            //     "회원가입이 완료되었습니다.",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: Colors.blue,
            //         fontSize: 24.0,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            //   child: Text(
            //     //  _readData();
            //     "아이디: ", // 이름 보이게 연동 할 것
            //     // '스마트 홈을 이용하실수 있는 ',
            //     //'아이디는 입니다.', // 아이디 보이게 연동 할 것
            //     style: TextStyle(fontSize: 18),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       textStyle: const TextStyle(color: Colors.white),
            //       padding: const EdgeInsets.only(top: 12, bottom: 12),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(25.0),
            //         side: const BorderSide(color: Colors.blue),
            //       ),
            //     ),
            //     child: const Text(
            //       '시작하기',
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //     ),
            //     onPressed: () {
            //       // _readData();

            //       // SharedPreferences _prefs;
            //       // _prefs = SharedPreferences.getInstance() as SharedPreferences;
            //       // _prefs.setString('id', _id);

            //       // LoginDataSave();
            //       // LoginDataRead();
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => LoginPage()));
            //     },
            // ),
            // )
          ],
        ));
  }
}
