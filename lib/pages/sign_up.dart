// import 'dart:html';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:convert';
import 'package:mysql_client/mysql_protocol.dart';
import 'package:crypto/src/sha256.dart' as sha;
import 'package:mysql_client/src/mysql_protocol/mysql_packet.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/pages/login_page.dart';
import 'package:project_flutter/pages/mysql.dart';
import 'package:project_flutter/userPreferences/data_table.dart';
import 'package:project_flutter/pages/signup_after.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Sign_up());

class LoginDataSave extends StatelessWidget {
  String _id = ''; // 추가
  String _pw = '';
  String _name = '';
  String _phone = '';
  String _address = '';
  String _email = '';

  Future<List<Profiles>> LoginSQLDataSave() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String sqlQuery =
          'INSERT into User (ID, Password, Name, Phone_Number, Address, Email) values (?, ?, ?, ?, ?, ?)';
      conn.query(sqlQuery, [
        _prefs.setString('ID', _id),
        _prefs.setString('Password', _pw),
        _prefs.setString('Name', _name),
        _prefs.setString('Phone_Number', _phone),
        _prefs.setString('Address', _address),
        _prefs.setString('Email', _email),
      ]);
    });
    return profileList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class LoginDataRead extends StatelessWidget {
  final TextEditingController idController = TextEditingController(); //ID
  Future<List<Profiles>> LoginSQLDataRead() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = "SELECT * FROM User WHERE ID = '${idController.text}'";
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final _id = _prefs.getString('ID') ?? '';
      final _pw = _prefs.getString('Password') ?? '';
      final _name = _prefs.getString('Name') ?? '';
      final _phone = _prefs.getString('Phone_Number') ?? '';
      final _address = _prefs.getString('Address') ?? '';
      final _email = _prefs.getString('Email') ?? '';

      conn.query(sqlQuery, [
        _prefs.getKeys(),
      ]);
    });
    return profileList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class LoginDataRemove extends StatelessWidget {
  final TextEditingController idController = TextEditingController(); //ID
  Future<List<Profiles>> LoginSQLDataRemove() async {
    // 로그아웃
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = "SELECT * FROM User WHERE ID = '${idController.text}'";
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final _id = _prefs.getString('ID') ?? '';
      final _pw = _prefs.getString('Password') ?? '';
      final _name = _prefs.getString('Name') ?? '';
      final _phone = _prefs.getString('Phone_Number') ?? '';
      final _address = _prefs.getString('Address') ?? '';
      final _email = _prefs.getString('Email') ?? '';

      conn.query(sqlQuery, [
        _prefs.remove('ID'),
        _prefs.remove('Password'),
        _prefs.remove('Name'),
        _prefs.remove('Phone_Number'),
        _prefs.remove('Address'),
        _prefs.remove('Email'),
      ]);
    });
    return profileList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  String _id = ''; // 추가
  String _pw = '';
  String _name = '';
  String _phone = '';
  String _address = '';
  String _email = '';

  late SharedPreferences _prefs; // 추가

  final db = Mysql();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController(); //ID
  final TextEditingController passwordController1 =
      TextEditingController(); // password1
  final TextEditingController passwordController2 =
      TextEditingController(); // password2
  final TextEditingController nameController = TextEditingController(); // name
  final TextEditingController phonenumberController =
      TextEditingController(); // phone number
  final TextEditingController addressController =
      TextEditingController(); // adress
  final TextEditingController emailController = TextEditingController(); //email

  // testPassword() {
  //   if (passwordController1.text == passwordController2.text) {
  //     print('비밀번호 일치');
  //     // (context) => Signup_after();
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("비밀번호가 일치합니다."),
  //         duration: Duration(milliseconds: 700)));
  //     MaterialPageRoute(builder: (context) => Signup_after());
  //     // Navigator.push(
  //     //     context, MaterialPageRoute(builder: (context) => Signup_after()));
  //     return '비밀번호 일치';
  //   } else {
  //     print('비밀번호 불일치');
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("비밀번호를 확인하세요."),
  //         duration: Duration(milliseconds: 700)));
  //     return null;
  //   }
  // }

  // void checkPassword() async {
  //   await testPassword();

  //   print("비밀번호 확인 완료");
  // }

  Digest encrypt() {
    var bytes = utf8.encode('${passwordController1.text}');

    Digest sha256Result = sha.sha256.convert(bytes);

    return sha256Result; // 암호화 한 값
  }

  void insertData() async {
    Digest encrpyted_password = encrypt();
    db.getConnection().then((conn) {
      String sqlQuery =
          'INSERT into User (ID, Password, Name, Phone_Number, Address, Email) values (?, ?, ?, ?, ?, ?)';
      conn.query(sqlQuery, [
        idController.text,
        encrpyted_password.toString(), // 암호화 된 비밀번호
        nameController.text,
        phonenumberController.text,
        addressController.text,
        emailController.text
      ]);
      setState(() {});
    });
    _id = idController.text; // 추가 // _id에 입력받은 값을 넣어줌
    _pw = encrpyted_password.toString();
    _name = nameController.text;
    _phone = phonenumberController.text;
    _address = addressController.text;
    _email = emailController.text;
  }

  @override // 추가
  void initState() {
    super.initState();
    LoginSQLDataSave();
  }

  // Future saveProfiles() async {
  //   Profiles newProfiles = Profiles(
  //       idController.text,
  //       passwordController1.text,
  //       nameController.text,
  //       phonenumberController.text,
  //       addressController.text,
  //       emailController.text ?? );
  // }

  Future<List<Profiles>> LoginSQLDataSave() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String sqlQuery =
          'INSERT into User (ID, Password, Name, Phone_Number, Address, Email) values (?, ?, ?, ?, ?, ?)';
      conn.query(sqlQuery, [
        _prefs.setString('ID', _id),
        _prefs.setString('Password', _pw),
        _prefs.setString('Name', _name),
        _prefs.setString('Phone_Number', _phone),
        _prefs.setString('Address', _address),
        _prefs.setString('Email', _email),
      ]);
      setState(() {});
    });
    return profileList;
  }

  Future<List<Profiles>> LoginSQLDataRead() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = "SELECT * FROM User WHERE ID = '${idController.text}'";
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final _id = _prefs.getString('ID') ?? '';
      final _pw = _prefs.getString('Password') ?? '';
      final _name = _prefs.getString('Name') ?? '';
      final _phone = _prefs.getString('Phone_Number') ?? '';
      final _address = _prefs.getString('Address') ?? '';
      final _email = _prefs.getString('Email') ?? '';

      conn.query(sqlQuery, [
        _prefs.getKeys(),
      ]);
      setState(() {});
    });
    return profileList;
  }

  Future<List<Profiles>> LoginSQLDataRemove() async {
    // 로그아웃
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = "SELECT * FROM User WHERE ID = '${idController.text}'";
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final _id = _prefs.getString('ID') ?? '';
      final _pw = _prefs.getString('Password') ?? '';
      final _name = _prefs.getString('Name') ?? '';
      final _phone = _prefs.getString('Phone_Number') ?? '';
      final _address = _prefs.getString('Address') ?? '';
      final _email = _prefs.getString('Email') ?? '';

      conn.query(sqlQuery, [
        _prefs.remove('ID'),
        _prefs.remove('Password'),
        _prefs.remove('Name'),
        _prefs.remove('Phone_Number'),
        _prefs.remove('Address'),
        _prefs.remove('Email'),
      ]);
      setState(() {});
    });
    return profileList;
  }

  _saveData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('ID', _id);
    _prefs.setString('Password', _pw);
    _prefs.setString('Name', _name);
    _prefs.setString('Phone_Number', _phone);
    _prefs.setString('Address', _address);
    _prefs.setString('Email', _email);
  }

  _readData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final _id = _prefs.getString('ID') ?? '';
    final _pw = _prefs.getString('Password') ?? '';
    final _name = _prefs.getString('Name') ?? '';
    final _phone = _prefs.getString('Phone_Number') ?? '';
    final _address = _prefs.getString('Address') ?? '';
    final _email = _prefs.getString('Email') ?? '';

    _prefs.getKeys();
  }

  _removeData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('ID');
    _prefs.remove('Password');
    _prefs.remove('Name');
    _prefs.remove('Phone_Number');
    _prefs.remove('Address');
    _prefs.remove('Email');
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    nameController.dispose();
    phonenumberController.dispose();
    addressController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = TextFormField(
      controller: idController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: '아이디',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '아이디를 입력해주세요.';
        }
        return null;
      },
    );

    final password1 = TextFormField(
      controller: passwordController1,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '비밀번호',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
    );

    final password2 = TextFormField(
      controller: passwordController2,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '비밀번호 확인',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '비밀번호를 입력해주세요.';
        } else if (value != password1) {
          return '비밀번호를 다시 확인해주세요.';
        } else {
          return null;
        }
      },
    );

    final name = TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          hintText: '이름',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '이름을 입력해주세요.';
        }
        return null;
      },
    );

    final phonenumber = TextFormField(
      controller: phonenumberController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: '휴대폰 번호',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '휴대폰 번호를 입력해주세요.';
        }
        return null;
      },
    );

    final address = TextFormField(
      controller: addressController,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
          hintText: '주소',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '주소를 입력해주세요.';
        }
        return null;
      },
    );

    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: '이메일 주소',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '이메일주소를 입력해주세요.';
        }
        return null;
      },
    );

    final signupButton = Padding(
      padding: EdgeInsets.all(20.0),
      child: GestureDetector(
        // onTap: () {
        //   // checkPassword();
        // },
        child: MaterialButton(
          minWidth: 200.0,
          height: 48.0,
          onPressed: () {
            insertData();
            LoginSQLDataSave();
            LoginSQLDataRead();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("회원가입을 환영합니다 " + " $_id" + "님"),
              duration: Duration(milliseconds: 700),
            ));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Signup_after()));
          },
          color: Color(0xff11600aa),
          child: Text('회원가입', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                        height: 1.7,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Nanum Barumpen',
                        fontStyle: FontStyle.normal),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              name,
              SizedBox(
                height: 8.0,
              ),
              id,
              SizedBox(
                height: 8.0,
              ),
              password1,
              SizedBox(
                height: 8.0,
              ),
              password2,
              SizedBox(
                height: 8.0,
              ),
              phonenumber,
              SizedBox(
                height: 8.0,
              ),
              address,
              SizedBox(
                height: 8.0,
              ),
              email,
              SizedBox(
                height: 8.0,
              ),
              signupButton,
            ],
          ),
        ));
  }
}
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: idController, // ID
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.account_tree),
//                     labelText: "아이디를 입력해주세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'ID'),
//                 validator: (String? id) {
//                   if (id!.isEmpty) {
//                     return "아이디를 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 obscureText: true, // 비밀번호 적을때 안보이도록
//                 controller: passwordController1, // password1
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.vpn_key),
//                     labelText: "회원가입할 비밀번호를 입력해주세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'password'),
//                 validator: (String? password) {
//                   if (password!.isEmpty) {
//                     return "비밀번호를 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 obscureText: true,
//                 controller: passwordController2, // password2
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.vpn_key),
//                     labelText: "비밀번호를 한번 더 입력해주세요",
//                     border: OutlineInputBorder(),
//                     hintText: 'password'),
//                 validator: (password) {
//                   if (passwordController2.text != passwordController1.text) {
//                     return "비밀번호가 일치하지 않습니다.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: nameController, // name
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.vpn_key),
//                     labelText: "이름을 입력해주세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'name'),
//                 validator: (name) {
//                   if (name!.isEmpty) {
//                     return "이름을 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: phonenumberController, //phone number
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.circle),
//                     labelText: "휴대폰 번호를 입력해주세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'phone number'),
//                 validator: (phone) {
//                   if (phone!.isEmpty) {
//                     return "휴대폰 번호를 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: addressController, // adress
//                 decoration: InputDecoration(
//                   icon: Icon(Icons.circle),
//                   labelText: "주소를 입력해주세요.",
//                   border: OutlineInputBorder(),
//                   hintText: 'adress',
//                 ),
//                 validator: (adress) {
//                   if (adress!.isEmpty) {
//                     return "주소를 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: emailController, // email
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.circle),
//                     labelText: "회원가입할 이메일을 입력하세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'E-mail'),
//                 validator: (email) {
//                   if (email!.isEmpty) {
//                     return "이메일을 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 16.0),
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     insertData();
//                     print("정상적으로 회원가입이 되었습니다.");
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Signup_after()));
//                   },
//                   child: Text('회원가입'),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
