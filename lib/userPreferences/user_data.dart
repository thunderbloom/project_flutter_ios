import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:project_flutter/userPreferences/data_table.dart';
import 'package:project_flutter/pages/mysql.dart';
import 'package:project_flutter/pages/show_user_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  String _id = ''; // 추가
  String _pw = '';
  String _name = '';
  String _phone = '';
  String _address = '';
  String _email = '';
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

  static Future<void> saveUserData(Profiles userData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userData.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  static Future<Profiles?> readUserData() async {
    Profiles? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? UserData = preferences.getString("currentUser");
    if (UserData != null) {
      Map<String, dynamic> userDataMap = jsonDecode(UserData);
      currentUserInfo =
          Profiles('id', 'password', 'name', 'phonenumber', 'address', 'email');
    }
    return currentUserInfo;
  }

  static Future<List<Profiles>> LoginSQLDataSave() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String sqlQuery =
          'INSERT into User (ID, Password, Name, Phone_Number, Address, Email) values (?, ?, ?, ?, ?, ?)';
      conn.query(sqlQuery, [
        _prefs.setString('ID', ''),
        _prefs.setString('Password', ''),
        _prefs.setString('Name', ''),
        _prefs.setString('Phone_Number', ''),
        _prefs.setString('Address', ''),
        _prefs.setString('Email', ''),
      ]);
    });
    return profileList;
  }

  static Future<List<Profiles>> LoginSQLDataRead() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = "SELECT * FROM User WHERE ID = (?)";
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

  static Future<List<Profiles>> LoginSQLDataRemove() async {
    // 로그아웃
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = "SELECT * FROM User WHERE ID = (?)";
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
}
