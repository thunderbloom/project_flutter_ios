import 'dart:ffi';

import 'package:flutter/material.dart';

class Profiles {
  String? ID;
  String? password;
  String? name;
  String? phonenumber;
  String? address;
  String? email;

  Profiles(
      {this.ID,
      this.password,
      this.name,
      this.phonenumber,
      this.address,
      this.email});
}

class Devices {
  String? id;
  String? Serial_Number;
  String? Model_Name;
  String? Device_Name;

  Devices({this.id, this.Serial_Number, this.Model_Name, this.Device_Name});
}

class History {
  String? serial_Number;
  String? topic;
  String? status;
  String? Datetime;

  History({this.serial_Number, this.topic, this.status, this.Datetime});
}

class Video {
  //Int? id;
  String? serial_number;
  String? video_path;
  String? file_name;
  DateTime? Datetime;

  Video({
    //this.id,
    this.serial_number,
    this.video_path,
    this.file_name,
    this.Datetime,
  });
}
