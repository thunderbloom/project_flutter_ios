import 'package:project_flutter/userPreferences/new_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_flutter/userPreferences/data_table.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writePerformance(Profiles1 performance) async {
    prefs.setString(
        performance.id.toString(), json.encode(performance.toJson()));
  }

  List<Profiles1> getPerformances() {
    List<Profiles1> performances = [];
    Set<String> keys = prefs.getKeys();
    keys.forEach((String key) {
      if (key != 'counter') {
        Profiles1 performances =
            Profiles1.fromJson(json.decode(prefs.getString(key) ?? ''));
        performances.add(performance);
      }
    });
    return performances;
  }

  Future setCounter() async {
    int counter = prefs.getInt('counter') ?? 0;
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getCounter() {
    return prefs.getInt('counter') ?? 0;
  }
}
