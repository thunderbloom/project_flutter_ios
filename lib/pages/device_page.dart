import 'package:flutter/material.dart';
import 'package:project_flutter/pages/data_table.dart';
import 'package:project_flutter/pages/mysql.dart';

void main() => runApp(DevicePage());

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});
  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final db = Mysql();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController serialController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController deviceController = TextEditingController();
  List<String> devices = [];
  String input = "";

  void insertData() async {
    db.getConnection().then((conn) {
      String sqlQuery =
          'INSERT into Device (id, Serial_Number, Model_Name, Device_Name) values (?, ?, ?, ?)';
      conn.query(sqlQuery, [
        idController.text,
        serialController.text,
        modelController.text,
        deviceController.text
      ]);
      setState(() {});
      print("기기정보가 등록되었습니다.");
    });
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    serialController.dispose();
    modelController.dispose();
    deviceController.dispose();
  }

  @override
  void initState() {
    super.initState();
    devices.add("Device1");
  }

  // Future<List<Devices>> deleteData() async {
  //   final List<Devices> deviceList = [];
  //   final Mysql db = Mysql();
  //   await db.getConnection().then((conn) async {
  //     print("데이터 삭제");
  //     String test = idController.text.toString();
  //     await conn
  //         .query("SELECT Serial_Number FROM Device WHERE id = 'sdf'")
  //         .then((result) {
  //       String device = result.toString();
  //       String dv = device.substring(25, device.length - 2);
  //       print(dv);
  //       if (dv == 'wsd') {
  //         print("일치");
  //         delete() async {
  //           await conn 
  //                 .query("delete Serial_Number from Device");
  //         };
  //       } else 
  //         setState(() {
            
  //         }); 
  //     });
  //     setState(() {});
  //   });
  //   return deviceList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("기기관리"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("기기등록"),
                  content: Column(children: [
                    TextFormField(
                      controller: idController,
                      decoration: InputDecoration(
                          labelText: "기기 아이디",
                          border: OutlineInputBorder(),
                          hintText: 'id'),
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    TextFormField(
                      controller: serialController,
                      decoration: InputDecoration(
                          labelText: "시리얼 번호",
                          border: OutlineInputBorder(),
                          hintText: 'serial number'),
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    TextFormField(
                      controller: modelController,
                      decoration: InputDecoration(
                          labelText: "모델 명",
                          border: OutlineInputBorder(),
                          hintText: 'model name'),
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    TextFormField(
                      controller: deviceController,
                      decoration: InputDecoration(
                          labelText: "기기 이름",
                          border: OutlineInputBorder(),
                          hintText: 'device name'),
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                  ]),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          insertData();
                          setState(() {
                            devices.add(input);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text("등록")),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          itemCount: devices.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(devices[index]),
              child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    title: Text(devices[index]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          devices.removeAt(index);
                          // deleteData();
                        });
                      },
                    ),
                  )),
            );
          }),
    );
  }
}
