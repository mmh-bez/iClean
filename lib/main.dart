import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/service/notification_helper.dart';
import 'package:i_clean/ui/attendant_screen.dart';
import 'package:i_clean/ui/dash_board.dart';
import 'package:i_clean/ui/dashboard_screen.dart';
import 'package:i_clean/ui/history_screen.dart';
import 'package:i_clean/ui/add_selected_item_screen.dart';
import 'package:i_clean/ui/intro_screen.dart';
import 'package:i_clean/ui/laundry/laundry_item_screen.dart';
import 'package:i_clean/ui/laundry/laundry_screen.dart';
import 'package:i_clean/ui/login_screen.dart';
import 'package:i_clean/ui/lostandfound/add_lost_found.dart';
import 'package:i_clean/ui/lostandfound/lost_and_found_screen.dart';
import 'package:i_clean/ui/minibar/minibar_item_screen.dart';
import 'package:i_clean/ui/minibar/minibar_screen.dart';
import 'package:i_clean/ui/minibar_co/minibar_co_item_scren.dart';
import 'package:i_clean/ui/minibar_co/minibar_co_screen.dart';
import 'package:i_clean/ui/room/room_screen.dart';
import 'package:i_clean/ui/supervisor/supervisor_screen.dart';
import 'package:i_clean/ui/supervisor_mode/super_visor_mode.dart';
import 'package:i_clean/ui/view_logs_screen.dart';
import 'package:i_clean/ui/wo_entry_screen.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _fcmBackgroundHandler(RemoteMessage message) async{
  print('Handling a background message ${message.notification}');
  print('Notification Message: ${message.notification.title}');

}
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
  final prefs = await SharedPreferences.getInstance();
  bool isFirst = prefs.getBool('isFirst');
  var brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
   isDarkModeEnabled = brightness == Brightness.dark;
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  if(isFirst != null && isFirst == true){
    if(savedThemeMode == AdaptiveThemeMode.light){
      isDarkModeEnabled = false;
    }else{
      isDarkModeEnabled = true;
    }
  }
  await SentryFlutter.init(
          (options) {
        options.dsn = 'https://d5c3c278a52645f2a699b70254f64e1c@o4504891509374976.ingest.sentry.io/4504891575500800';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
      },
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
    ChangeNotifierProvider<AppProvider>(
    create: (BuildContext context) => AppProvider(),
    ),
      ],
      child: AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
        ),
        initial: isDarkModeEnabled ? AdaptiveThemeMode.dark:AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          home: IntroScreen(),
          routes: <String, WidgetBuilder>{
            IntroScreen.routeName: (BuildContext context) => IntroScreen(),
            AddSelectedItemScreen.routeName: (BuildContext context) => AddSelectedItemScreen(),
            LoginScreen.routeName: (BuildContext context) => LoginScreen(),
            DashBoard.routeName: (BuildContext context) => DashBoard(),
            AttendantScreen.routeName:(BuildContext context) => AttendantScreen(),
            HistoryScreen.routeName:(BuildContext context) => HistoryScreen(),
            LaundryScreen.routeName:(BuildContext context) => LaundryScreen(),
            LostAndFoundScreen.routeName: (BuildContext context) => LostAndFoundScreen(),
            MiniBarScreen.routeName:(BuildContext context) => MiniBarScreen(),
            RoomScreen.routeName:(BuildContext context) => RoomScreen(),
            SupervisorScreen.routeName:(BuildContext context) => SupervisorScreen(),
            SupervisorModScreen.routeName:(BuildContext context) => SupervisorModScreen(),
            ViewLogsScreen.routeName:(BuildContext context) => ViewLogsScreen(),
            WoEntryScreen.routeName:(BuildContext context) => WoEntryScreen(),
            AddLostFoundScreen.routeName:(BuildContext context) => AddLostFoundScreen(),
            MiniBarCoScreen.routeName:(BuildContext context) => MiniBarCoScreen(),
            LaundryItemScreen.routeName:(BuildContext context) => LaundryItemScreen(),
            MinibarItemScreen.routeName:(BuildContext context) => MinibarItemScreen(),
            MinibarCoItemScreen.routeName:(BuildContext context) => MinibarCoItemScreen(),
            DashBoardScreen.routeName: (BuildContext context) => DashBoardScreen(),


          },

        ),
      ),
    );
  }
}
