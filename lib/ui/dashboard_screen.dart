import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/ui/attendant_screen.dart';
import 'package:i_clean/ui/history_screen.dart';
import 'package:i_clean/ui/intro_screen.dart';
import 'package:i_clean/ui/laundry/laundry_screen.dart';
import 'package:i_clean/ui/login_screen.dart';
import 'package:i_clean/ui/lostandfound/lost_and_found_screen.dart';
import 'package:i_clean/ui/minibar/minibar_screen.dart';
import 'package:i_clean/ui/minibar_co/minibar_co_screen.dart';
import 'package:i_clean/ui/room/room_screen.dart';
import 'package:i_clean/ui/supervisor/supervisor_screen.dart';
import 'package:i_clean/ui/supervisor_mode/super_visor_mode.dart';
import 'package:i_clean/ui/view_logs_screen.dart';
import 'package:i_clean/ui/wo_entry_screen.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/screen_size.dart';


class DashBoardScreen extends StatefulWidget {
  static const routeName = '/dashboardScreen';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateDashBoardScreen();
  }
}

class _StateDashBoardScreen extends State<DashBoardScreen> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    Provider.of<AppProvider>(context, listen:false).getDashBoardData(context);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    Provider.of<AppProvider>(context, listen:false).getDashBoardData(context);
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  @override
  void initState() {
    Provider.of<AppProvider>(context, listen:false).getDashBoard(context);
    Provider.of<AppProvider>(context, listen:false).getDashBoardData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().initSizeConig(context);
    // TODO: implement build
    return Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation){
            return Consumer<AppProvider>(
              builder: (context , model , _){
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white54,
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5, top: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(

                                      child:  ListTile(
                                          leading: CircleAvatar(
                                            radius: 20,
                                            child: Image.asset('assets/images/human.png'),
                                          ),
                                          title: Text(
                                            'Hi',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                          subtitle: Text(name),
                                          trailing: Container(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                DayNightSwitcher(
                                                  isDarkModeEnabled: isDarkModeEnabled,
                                                  onStateChanged: (enable) async{
                                                    final prefs = await SharedPreferences.getInstance();
                                                    setState(() {

                                                      isDarkModeEnabled = enable;
                                                       prefs.setBool('isFirst', true);
                                                      if(isDarkModeEnabled == false){
                                                        AdaptiveTheme.of(context).setLight();
                                                      }else{
                                                        AdaptiveTheme.of(context).setDark();
                                                      }
                                                    });
                                                  },
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                    icon: Icon(Icons.history ,),
                                                    onPressed: () {
                                                      Navigator.pushNamed(context, HistoryScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                                    },),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                    icon: Icon(Icons.logout),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(IntroScreen.routeName, (Route<dynamic> route) => false);
                                                    },),
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(

                          height: double.infinity,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: double.infinity,
                                width:  ScreenSizeConfig.screenWidth/2.2,
                                child:  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, AttendantScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));

                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(

                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          elevation: 8,
                                          child: ClipPath(
                                            clipper: ShapeBorderClipper(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10))),
                                            child: Container(
                                                height: 120,
                                                width: MediaQuery.of(context).size.width /2.4,
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                          color: Colors.orangeAccent,
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(right: 4),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Icon(Icons.note_add , size: 80, color: Colors.white,),
                                                              Container(
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(model.assignedTask.toString() , style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.white, fontSize: 18),),
                                                                      Text('Assigned \nTasks',  textAlign: TextAlign.end, style: TextStyle(color: Colors.white),),
                                                                    ]
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                    Container(
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white54,
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 12 , right: 8),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('View Details'  ),
                                                              Icon(Icons.forward_outlined),
                                                            ],
                                                          ),
                                                        )


                                                    ),


                                                  ],
                                                )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),

                                      Visibility(
                                        visible: isAdmin,
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, SupervisorScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));

                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            elevation: 8,
                                            child: ClipPath(
                                              clipper: ShapeBorderClipper(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10))),
                                              child: Container(
                                                  height: 120,
                                                  width: MediaQuery.of(context).size.width /2.4,
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                            color: Colors.blueAccent,
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 8 , right: 8),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Icon(Icons.view_list_outlined , size: 80, color: Colors.white,),
                                                                Container(
                                                                  child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [

                                                                        Text(model.inspectRoom.toString() , style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.white, fontSize: 18),),
                                                                        Text('Rooms to \ninspect!',  textAlign: TextAlign.end, style: TextStyle(color: Colors.white),),
                                                                      ]
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                      ),
                                                      Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white54,
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 12 , right: 8),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('View Details'  ),
                                                                  Icon(Icons.forward_outlined),
                                                                ],
                                                              ),
                                                            )


                                                      ),


                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                              ),
                              Container(
                                  width: ScreenSizeConfig.screenWidth/2,
                                  child: /*Container(
                              child: GridView.count(
                                  childAspectRatio: orientation == Orientation.portrait ?  1 : 1.65,
                                  crossAxisCount: MediaQuery.of(context).size.width <= 800.0 ? 2 :  3 ,
                                  scrollDirection: Axis.vertical,
                                  // crossAxisCount: 3,
                                  children: List.generate(
                                      model.dashBoardList.length, (index) {
                                    return Padding(
                                      padding: EdgeInsets.only( bottom: 10 , left: 6 , right: 6),
                                      child: GestureDetector(
                                        onTap: ()async{
                                          if(model.dashBoardList[index].id == 1){
                                            Navigator.pushNamed(context, AttendantScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                          }else if(model.dashBoardList[index].id == 2){
                                            if(isAdmin){
                                              Navigator.pushNamed(context, SupervisorScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                            }else{
                                              showSnackBar(context);
                                            }
                                          }
                                          else if(model.dashBoardList[index].id == 10){
                                            if(isAdmin){
                                              Navigator.pushNamed(context, SupervisorModScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                            }else{
                                              showSnackBar(context);
                                            }

                                          }else if(model.dashBoardList[index].id == 3){
                                            if(isAdmin){
                                              Navigator.pushNamed(context, RoomScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                            }else{
                                              showSnackBar(context);
                                            }

                                          }
                                          else if(model.dashBoardList[index].id == 10){
                                            if(isAdmin){
                                              Navigator.pushNamed(context, SupervisorScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                            }else{
                                              showSnackBar(context);
                                            }

                                          }else if(model.dashBoardList[index].id == 4){
                                            if(isAdmin){
                                              Navigator.pushNamed(context, MiniBarScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                            }else{
                                              showSnackBar(context);
                                            }
                                          }else if(model.dashBoardList[index].id == 5){
                                            if(isAdmin ){
                                              Navigator.pushNamed(context, MiniBarCoScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                            }else{
                                              showSnackBar(context);
                                            }
                                          }else if(model.dashBoardList[index].id == 6){
                                            if(isAdmin){
                                              Navigator.pushNamed(context, LaundryScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                            }else{
                                              showSnackBar(context);
                                            }
                                          }else if(model.dashBoardList[index].id == 7){
                                            Navigator.pushNamed(context, LostAndFoundScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                          }else if(model.dashBoardList[index].id == 8){
                                            Navigator.pushNamed(context, WoEntryScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                          }else if(model.dashBoardList[index].id == 9){
                                            if(isAdmin){
                                              Navigator.pushNamed(context, ViewLogsScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
                                            }else{
                                              showSnackBar(context);
                                            }
                                          }
                                        },
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1.5,
                                              color: Color(0xFFF88D2A), //<-- SEE HERE
                                            ),
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              if (model.dashBoardList[index].id == 1)...[
                                                showIcon(FontAwesomeIcons.tasks ),
                                              ] else if(model.dashBoardList[index].id == 2)...[
                                                showIcon(FontAwesomeIcons.pencilSquare),
                                              ]
                                              else if(model.dashBoardList[index].id == 10)...[
                                                  showIcon(FontAwesomeIcons.pencilSquare),
                                                ]else if(model.dashBoardList[index].id == 3)...[
                                                  showIcon(FontAwesomeIcons.building),
                                                ]else if(model.dashBoardList[index].id == 4)...[
                                                  showIcon(FontAwesomeIcons.wineGlass),
                                                ]else if(model.dashBoardList[index].id == 5)...[
                                                  showIcon(FontAwesomeIcons.wineGlass),
                                                ]else if(model.dashBoardList[index].id == 6)...[
                                                  showIcon( Icons.local_laundry_service_outlined, ),
                                                ]else if(model.dashBoardList[index].id == 7)...[
                                                  showIcon(FontAwesomeIcons.folder),
                                                ]else if(model.dashBoardList[index].id == 8)...[
                                                  showIcon(FontAwesomeIcons.pencil),
                                                ]else if(model.dashBoardList[index].id == 9)...[
                                                  showIcon(FontAwesomeIcons.fileText),
                                                ],
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Center(child: Text(model.dashBoardList[index].name , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),))
                                            ],
                                          ),
                                        ),
                                      ),


                                    );
                                  }
                                  )
                              ),
                              )*/
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Flexible(
                                    flex: 1,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            dashboardContainer("Attendant", FontAwesomeIcons.tasks , context ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            dashboardContainer("Supervisor", FontAwesomeIcons.pencilSquare , context),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            dashboardContainer("Supervisor Mode", FontAwesomeIcons.pencilSquare , context),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            dashboardContainer("Rooms", FontAwesomeIcons.building , context),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            dashboardContainer("Minibar", FontAwesomeIcons.wineGlass, context ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            dashboardContainer("Minibar/CO", FontAwesomeIcons.wineGlass , context),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            dashboardContainer("Laundry", Icons.local_laundry_service_outlined , context),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            dashboardContainer("Lost & Found", FontAwesomeIcons.folder, context ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            dashboardContainer("WO Entry", FontAwesomeIcons.pencil, context ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            dashboardContainer("View Logs", FontAwesomeIcons.fileText, context ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              },

            );
          },

        ));
  }


Widget showIcon(IconData icon ){
  return FaIcon(icon , size: 60 , color: Color(0xFFF88D2A),);
}

Widget dashboardContainer(String name ,IconData icon  ,BuildContext context ){
  return  Expanded(
      child: GestureDetector(
        onTap: ()async{
          if(name == 'Attendant'){
            Navigator.pushNamed(context, AttendantScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
          }else if(name == 'Supervisor'){
            if(isAdmin){
              Navigator.pushNamed(context, SupervisorScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
            }else{
              showSnackBar(context);
            }
          }
          else if(name == 'Supervisor Mode'){
            if(isAdmin){
              Navigator.pushNamed(context, SupervisorModScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
            }else{
              showSnackBar(context);
            }

          }else if(name == 'Rooms'){
            if(isAdmin){
              Navigator.pushNamed(context, RoomScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
            }else{
              showSnackBar(context);
            }

          }else if(name == 'Minibar'){
            if(isAdmin){
              Navigator.pushNamed(context, MiniBarScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
            }else{
              showSnackBar(context);
            }
          }else if(name == 'Minibar/CO'){
            if(isAdmin ){
              Navigator.pushNamed(context, MiniBarCoScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
            }else{
              showSnackBar(context);
            }
          }else if(name == 'Laundry'){
            if(isAdmin){
              Navigator.pushNamed(context, LaundryScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
            }else{
              showSnackBar(context);
            }
          }else if(name == 'Lost & Found'){
            Navigator.pushNamed(context, LostAndFoundScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
          }else if(name == 'WO Entry'){
            Navigator.pushNamed(context, WoEntryScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
          }else if(name == 'View Logs'){
            if(isAdmin){
              Navigator.pushNamed(context, ViewLogsScreen.routeName).then((value) =>     Provider.of<AppProvider>(context, listen:false).getDashBoardData(context));
            }else{
              showSnackBar(context);
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 12 , right: 12),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.5,
                color: Color(0xFFF88D2A), //<-- SEE HERE
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  showIcon(icon ),
                  Center(child: Text(name ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),textAlign: TextAlign.center,)),
                ],
              ),
            ),
          ),
        ),
      ),

  );
}

void showSnackBar(BuildContext context) {
  final snackBar =SnackBar(
    content: const Text('Access Denied.This is only for admin.'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);


}
}
