import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '34.64.233.244',
                user = 'root',
                password = 'qwer123',
                db = 'project';
  static int port = 3306;

  Mysql(); 
  
  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(settings);
  }
}