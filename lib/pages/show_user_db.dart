import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:project_flutter/pages/mysql.dart';
import 'package:project_flutter/pages/data_table.dart';

class UserData extends StatefulWidget {
  const UserData({
    Key? key,
  }) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  Future<List<Profiles>> getSQLData() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery =
          //'select ID, password, name, phonenumber, address, email from User';
          'select ID, password, email from User';
      await conn.query(sqlQuery).then((result) {
        for (var res in result) {
          final profileModel = Profiles(
              ID: res["ID"],
              password: res["password"],
              //name: res["name"],
              //phonenumber: res["phonenumber"],
              email: res["email"]);
          profileList.add(profileModel);
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      conn.close();
    });
    return profileList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getDBData(),
      ),
    );
  }

  FutureBuilder<List> getDBData() {
    return FutureBuilder<List>(
        future: getSQLData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data as List;
              return ListTile(
                leading: Text(
                  data[index].ID.toString(),
                  style: const TextStyle(fontSize: 25),
                ),
                title: Text(
                  data[index].email.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  data[index].password.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              );
            },
          );
        });
  }
}
