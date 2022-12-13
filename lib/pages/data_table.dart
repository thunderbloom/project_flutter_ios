import 'package:flutter/material.dart';

class Profiles {
  String? ID;
  String? password;
  String? name;
  String? phonenumber;
  String? address;
  String? email;

  Profiles({
      this.ID,
      this.password,
      this.name,
      this.phonenumber,
      this.address,
      this.email
      });
}

class Devices {
  String? id;
  String? Serial_Number;
  String? Model_Name;
  String? Device_Name;

  Devices({
    this.id,
    this.Serial_Number, 
    this.Model_Name, 
    this.Device_Name
    });
}
