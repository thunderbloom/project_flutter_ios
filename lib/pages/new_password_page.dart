import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/userPreferences/data_table.dart';
import 'package:project_flutter/pages/login_page.dart';
import 'package:project_flutter/pages/mysql.dart';
import 'package:crypto/src/sha256.dart' as sha;

class PassWordReset extends StatefulWidget {
  const PassWordReset({Key? key}) : super(key: key);

  @override
  State<PassWordReset> createState() => _PassWordResetState();
}

class _PassWordResetState extends State<PassWordReset> {
  final db = Mysql();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final idController = TextEditingController();

  Digest encrypt() {
    var bytes = utf8.encode('${passwordController1.text}');

    Digest sha256Result = sha.sha256.convert(bytes);

    return sha256Result; // 암호화 한 값
  }

  void passwordUpdate() async {
    Digest encrpyted_password = encrypt(); // 비밀번호 암호화
    db.getConnection().then((conn) {
      String sqlQuery = "UPDATE User SET Password = (?) where ID = (?)";
      conn.query(sqlQuery, [
        encrpyted_password.toString(),
        idController.text,
      ]);
      setState(() {
        if (passwordController1.text == passwordController2.text) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
          setState(() {
            print("비밀번호 일치");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("비밀번호가 변경되었습니다.."),
                duration: Duration(milliseconds: 700)));
          });
        } else
          setState(() {
            print("비밀번호 불일치");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("비밀번호를 확인해주세요."),
              duration: Duration(milliseconds: 700),
            ));
          });
      });
    });
  }

  @override
  void dispose() {
    passwordController1.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              '아이디를 입력해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: idController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'ID',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              '새 비밀 번호를 입력해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: passwordController1,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'password',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              '새 비밀번호를 다시 한 번 입력해주세요',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: passwordController2,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'password',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              passwordUpdate();
            },
            child: Text('reset'),
            color: Colors.deepPurple[200],
          )
        ],
      ),
    );
  }
}
