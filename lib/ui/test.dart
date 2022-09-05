import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/notification_service.dart';

class Test extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateTest();
  }

}

class _StateTest extends State<Test> {

   NotificationService notificationService;
  @override
  void initState() {
    notificationService = NotificationService();

    notificationService.initializePlatformNotifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
        onPressed: () async {
      await notificationService.showLocalNotification(
          id: 0,
          title: "Drink Water",
          body: "Time to drink some water!",
          payload: "You just took water! Huurray!");
    },
    child: const Text("Drink Now"),
        ),
      ),
      ),
    );
  }
}