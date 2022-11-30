import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper{

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)async{
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitialize , iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationSettings , onSelectNotification: (String payLoad)async{
      try{
        if(payLoad !=null && payLoad.isNotEmpty){

        }else{

        }
      }catch(e){

      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          'iClean', "iClean" , importance: Importance.max , priority: Priority.max , playSound: true);

      NotificationDetails platformChannelSpecific = NotificationDetails(android: androidNotificationDetails ,
          iOS: IOSNotificationDetails());

      await flutterLocalNotificationsPlugin.show(0, message.notification.title, message.notification.body,
          platformChannelSpecific);

    });




  }
}