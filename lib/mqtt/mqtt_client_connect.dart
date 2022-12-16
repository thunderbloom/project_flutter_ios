import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:project_flutter/pages/notification_service.dart';

import 'dart:io';
import 'package:get/get.dart';

// void _showDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: new Text("Alert!!"),
//         content: new Text("You are awesome!"),
//         actions: <Widget>[
//           new TextButton(
//             child: new Text("OK"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// void openDialog() {  
//   print('dialog');
//   Get.dialog(
//     AlertDialog(
//       title: const Text('test'),
//       content: const Text('test body'),
//       actions: [
//         TextButton(
//           child: const Text("Close"),
//           onPressed: () => Get.back(),
//         ),
//       ],
//     ),
//   );
// } 


Future<MqttClient> connect() async {
  MqttServerClient client = 
    MqttServerClient.withPort('34.64.233.244', 'ayWebSocketClient_123456_33f7423c-a3b7-46b1-8a1a-26937e4a071f', 19883);
  client.logging(on : true);
  client.onConnected = onConnected;
  
  client.onDisconnected =  onDisconnected;
  client.keepAlivePeriod = 20;
  // client.onUnsubscribed = onUnsubscribed;
  
  client.port = 19883;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;

  // NotificationService notificationService = NotificationService();
  
  final connMess = MqttConnectMessage()
      .withClientIdentifier("ayWebSocketClient_123456_33f7423c-a3b7-46b1-8a1a-26937e4a071f")
      .authenticateAs("admin", "qwer123")
      // .keepAliveFor(60)
      .withWillTopic('willtopic')
      .withWillMessage("My Will message")
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMess;

  try {
    print('Connecting');
    await client.connect("admin", "qwer123");
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  }

  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('EMQX client connected');
    print("접속완료");
    const topic = 'house/door';
    
    // client.subscribe(topic, MqttQos.atLeastOnce);
    client.subscribe('house/door', MqttQos.atLeastOnce);
    client.subscribe('house/door1', MqttQos.atLeastOnce);
    client.subscribe('house/door2', MqttQos.atLeastOnce);
    client.subscribe('house/window', MqttQos.atLeastOnce);
    client.subscribe('house/window1', MqttQos.atLeastOnce);
    client.subscribe('house/window2', MqttQos.atLeastOnce);
    client.subscribe('house/camera', MqttQos.atLeastOnce);
    client.subscribe('house/camera1', MqttQos.atLeastOnce);
    client.subscribe('house/camera2', MqttQos.atLeastOnce);

    // client.update?.listen 이 callback 함수 역할을 함.
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      // final MqttMessage message = c[0].payload;
      // final payload = 
      //   MqttPublishPayload.bytesToStringAsString(message.toString()); //.payload.message;
      // await notificationService.showNotification(0, 'This is title...', "Tis is body...",);
      // print('Received message:$payload from topic: ${c[0].topic}>');
      // NotificationService()
      // .showNotification(1, 'check your mailbox', 'you have new mail', 1);
      // await notificationService.showNotification(1, 'This is title...', "This is body...",);
      // openDialog();
      print('Received message: from topic: ${c[0].topic}>');
      
      
      
    });

    client.published?.listen((MqttPublishMessage message) {
      print('published');
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      // openDialog();
      // await notificationService.showNotification(0, 'This is title...', "This is body...",);     
      print(        
        'Published message: $payload to topic: ${message.variableHeader?.topicName}'
      );
    });
  } else {
    print(
      'EMQX client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
    exit(-1);
    
  }
  return client;
}




void onMessage() { print('Message Arrived');}
void onConnected() {  print('Connected');}
void onDisconnected() { print('Disconneted');}
void onSubscribed(String topic) { print('subscribed topic: $topic');}
void onSubscribeFail(String topic) { print('Failed to subscribe: $topic');}
void onUnsubscribed(String topic) { print('Unsubscribed topic: $topic');}
void pong() { print('Ping response client callback invoked');}