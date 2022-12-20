import 'package:flutter/material.dart';
import 'package:project_flutter/userPreferences/new_data.dart';
import 'package:project_flutter/userPreferences/sp_helper.dart';
import 'package:project_flutter/userPreferences/user_data.dart';
import 'package:project_flutter/userPreferences/data_table.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({Key? key}) : super(key: key);

  @override
  _PerformanceScreenState createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  List<Profiles1> performances = [];
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();
  final SPHelper helper = SPHelper();

  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('독서 트레이닝')),
      body: ListView(
        children: getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showPerformanceDialog(context);
        },
      ),
    );
  }

  Future<dynamic> showPerformanceDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('독서 기록 하기'),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextField(
                  controller: txtDescription,
                  decoration: InputDecoration(hintText: '책 제목&설명'),
                ),
                TextField(
                  controller: txtDuration,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: '독서량(분)'),
                ),
              ],
            )),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                  txtDescription.text = '';
                  txtDuration.text = '';
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: savePerformance,
              )
            ],
          );
        });
  }

  Future savePerformance() async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    Profiles1 newPerformance = Profiles1(
        1, today, txtDescription.text, int.tryParse(txtDuration.text) ?? 0);
    helper.writePerformance(newPerformance).then((_) => updateScreen());
    txtDescription.text = '';
    txtDuration.text = '';
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    performances.forEach((profiles1) {
      tiles.add(ListTile(
          title: Text(profiles1.description),
          subtitle: Text('${profiles1.date} - 기간: ${profiles1.duration} 분')));
    });
    return tiles;
  }

  void updateScreen() {
    performances = helper.getPerformances();
    setState(() {});
  }
}
