import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class Profiles {
  String ID = '';
  String Password = '';
  String Name = '';
  String Phone_Number = '';
  String Address = '';
  String Email = '';

  Profiles(this.ID, this.Password, this.Name, this.Phone_Number, this.Address,
      this.Email);

  Profiles.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Password = json['password'],
        Name = json['name'],
        Phone_Number = json['phonenumber'],
        Address = json['address'],
        Email = json['email'];

  // String get id => ID;
  // set setId(String id) => ID = id;

  // String get password => Password;
  // set setPassword(String password) => Password = password;

  // String get name => Name;
  // set setName(String name) => Name = name;

  // String get phonenumber => Phone_Number;
  // set setPhone_Number(String phonenumber) => Phone_Number = phonenumber;

  // String get email => Email;
  // set setEmail(String email) => Email = email;

  Map<String, Object> toJson() {
    return {
      "id": ID,
      "password": Password,
      "name": Name,
      "phonenumber": Phone_Number,
      "address": Address,
      "email": Email,
    };
  }

  void add(Profiles profiles) {}

  // @override
  // String toString() {
  //   return '{"id": "$ID", "password": "$Password", "name": "$Name", "phonenumber": "$Phone_Number", "address": "$Address", "email": "$Email"}';
  // }
}

class Devices {
  String? id;
  String? Serial_Number;
  String? Model_Name;
  String? Device_Name;

  Devices({this.id, this.Serial_Number, this.Model_Name, this.Device_Name});
}
