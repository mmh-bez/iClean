import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)async{
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitialize , iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationSettings , onSelectNotification: (String payLoad)async{
      try{
        if(payLoad !=null && payLoad.isNotEmpty){
          print('asdfsdf');
        }else{
          print('asdfsdf1111');
        }
      }catch(e){
        print('asdfsdf2222');
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          'iClean', "iClean" , importance: Importance.max , priority: Priority.max , playSound: true);

      NotificationDetails platformChannelSpecific = NotificationDetails(android: androidNotificationDetails ,
          iOS: IOSNotificationDetails());

      /*await flutterLocalNotificationsPlugin.show(0, message.data["title"], message.data["body"],
          platformChannelSpecific);*/

      await flutterLocalNotificationsPlugin.show(0, message.notification.title, message.notification.body,
          platformChannelSpecific);

    });




/*    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  'iClean', "iClean" , importance: Importance.max , priority: Priority.max , playSound: true
                // other properties...
              ),
                iOS: IOSNotificationDetails()
            ));
      }
    });*/

  }
}