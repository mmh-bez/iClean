import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/ui/attendant_screen.dart';
import 'package:i_clean/ui/dash_board.dart';
import 'package:i_clean/ui/history_screen.dart';
import 'package:i_clean/ui/add_selected_item_screen.dart';
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
import 'package:i_clean/ui/view_logs_screen.dart';
import 'package:i_clean/ui/wo_entry_screen.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
    ChangeNotifierProvider<AppProvider>(
    create: (BuildContext context) => AppProvider(),
    ),
      ],
      child: GetMaterialApp(
        navigatorKey: alice.getNavigatorKey(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange,
          primarySwatch: Colors.orange,
          brightness: Brightness.light,

        ),
        home: LoginScreen(),
        routes: <String, WidgetBuilder>{
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
          ViewLogsScreen.routeName:(BuildContext context) => ViewLogsScreen(),
          WoEntryScreen.routeName:(BuildContext context) => WoEntryScreen(),
          AddLostFoundScreen.routeName:(BuildContext context) => AddLostFoundScreen(),
          MiniBarCoScreen.routeName:(BuildContext context) => MiniBarCoScreen(),
          LaundryItemScreen.routeName:(BuildContext context) => LaundryItemScreen(),
          MinibarItemScreen.routeName:(BuildContext context) => MinibarItemScreen(),
          MinibarCoItemScreen.routeName:(BuildContext context) => MinibarCoItemScreen(),

        },

      ),
    );
  }
}
