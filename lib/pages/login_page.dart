import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_flutter/pages/data_table.dart';
import 'package:project_flutter/pages/device_page.dart';
import 'package:project_flutter/pages/password_encrypt.dart';
import 'package:project_flutter/pages/show_device_db.dart';
import 'package:project_flutter/pages/show_user_db.dart';
import 'package:project_flutter/pages/signup.dart';
import 'package:project_flutter/pages/mysql.dart';
import 'package:project_flutter/pages/main_page.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final db = Mysql();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    passwordController.dispose();
  }

  Future<List<Profiles>> getSQLData() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String test = idController.text.toString();
      await conn
          .query("SELECT Password FROM User WHERE ID = '${idController.text}'")
          .then((result) {
        String pass = result.toString();
        String test_pass = passwordController.text.toString();
        String pw = pass.substring(20, pass.length - 2);
        if (pw == test_pass) {
          print("패스워드 일치");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Loding())); // 메인화면으로 바꿀것
        } else
          setState(() {
            print("패스워드 불일치");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("비밀번호가 틀립니다." + pass),
              duration: Duration(milliseconds: 700),
            ));
          });
      });
      setState(() {});
    });
    return profileList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getDBdata(),
      ),
    );
  }

  FutureBuilder<List> getDBdata() {
    return FutureBuilder<List>(builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }
      return MaterialApp(
        title: 'Login',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 120),
              child: Column(
                children: <Widget>[
                  Hero(
                      tag: 'Hero',
                      child: CircleAvatar(
                        child: Image.asset('assets/images/temp_logo.jpg'),
                        backgroundColor: Colors.transparent,
                        radius: 58.0,
                      )),
                  SizedBox(height: 45.0),
                  TextFormField(
                    controller: idController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: '아이디', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: '비밀번호', border: OutlineInputBorder()),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1160aa),
                        foregroundColor: Colors.white),
                    child: Text('로그인'),
                    onPressed: () {
                      getSQLData();
                    },
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1160aa),
                        foregroundColor: Colors.white),
                    child: Text('회원가입'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sign_up()),
                      );
                    },
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1160aa),
                        foregroundColor: Colors.white),
                    child: Text('기기등록'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DevicePage()),
                      );
                    },
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1160aa),
                        foregroundColor: Colors.white),
                    child: Text('회원정보'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserData()),
                      );
                    },
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1160aa),
                        foregroundColor: Colors.white),
                    child: Text('디바이스정보'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeviceData()),
                      );
                    },
                  ),
                ],
              )),
        ),
      );
    });
  }
}
