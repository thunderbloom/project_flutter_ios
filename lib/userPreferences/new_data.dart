import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Profiles1 {
  int id = 0;
  String date = '';
  String description = '';
  int duration = 0;

  Profiles1(this.id, this.date, this.description, this.duration);

  Profiles1.fromJson(Map<String, dynamic> profiles1) {
    id = profiles1['id'] ?? 0;
    date = profiles1['date'] ?? '';
    description = profiles1['description'] ?? '';
    duration = profiles1['duration'] ?? 0;

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'date': date,
        'description': description,
        'duration': duration
      };
    }
  }
}
