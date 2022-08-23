import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/ui/attendant_screen.dart';
import 'package:i_clean/ui/history_screen.dart';
import 'package:i_clean/ui/laundry/laundry_screen.dart';
import 'package:i_clean/ui/login_screen.dart';
import 'package:i_clean/ui/lostandfound/lost_and_found_screen.dart';
import 'package:i_clean/ui/minibar/minibar_screen.dart';
import 'package:i_clean/ui/minibar_co/minibar_co_screen.dart';
import 'package:i_clean/ui/room/room_screen.dart';
import 'package:i_clean/ui/supervisor/supervisor_screen.dart';
import 'package:i_clean/ui/view_logs_screen.dart';
import 'package:i_clean/ui/wo_entry_screen.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';


class DashBoard extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateDashBoard();
  }
}

class _StateDashBoard extends State<DashBoard> {

  @override
  void initState() {
    Provider.of<AppProvider>(context, listen:false).getDashBoard(context);
    Provider.of<AppProvider>(context, listen:false).getDashBoardData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Consumer<AppProvider>(
          builder: (context , model , _){
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                children: [
                  Container(
                        color: Colors.white54,
                        width: double.infinity,
                        height: 280,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5, top: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      child:  ListTile(
                                        leading: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                            'https://source.unsplash.com/50x50/?portrait',
                                          ),
                                        ),
                                        title: Text(
                                          'Hi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                        subtitle: Text(name),
                                        trailing: Container(
                                          width: 60,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: IconButton(
                                                  icon: Icon(Icons.history ,),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, HistoryScreen.routeName);
                                                  },),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                  icon: Icon(Icons.logout),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(LoginScreen.routeName, (Route<dynamic> route) => false);
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
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(context, SupervisorScreen.routeName);

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
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 8 , right: 8),
                                                    child: Container(
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white54,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('View Details' , style: TextStyle(color: Colors.orangeAccent), ),
                                                            Icon(Icons.forward_outlined ,color: Colors.orangeAccent,),
                                                          ],
                                                        )

                                                    ),
                                                  ),


                                                ],
                                              )),
                                        ),
                                      ),
                                    ),

                                    Visibility(
                                      visible: isAdmin,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, AttendantScreen.routeName);
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
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 8 , right: 8),
                                                      child: Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white54,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('View Details' , style: TextStyle(color: Colors.blue), ),
                                                              Icon(Icons.forward_outlined ,color: Colors.blue,),
                                                            ],
                                                          )

                                                      ),
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
                            ],
                          ),
                        ),
                      ),
                   Expanded(
                  child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10 ),
                                child: GridView.count(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: ScrollPhysics(),
                                    crossAxisCount: 3,
                                    children: List.generate(
                                        model.dashBoardList.length, (index) {
                                      return Padding(
                                        padding: EdgeInsets.only( bottom: 10 , left: 6 , right: 6),
                                        child: GestureDetector(
                                          onTap: ()async{
                                            if(model.dashBoardList[index].id == 1){
                                              Navigator.pushNamed(context, AttendantScreen.routeName);
                                            }else if(model.dashBoardList[index].id == 2){
                                              if(isAdmin){
                                                Navigator.pushNamed(context, SupervisorScreen.routeName);
                                              }else{
                                                showSnackBar(context);
                                              }
                                            }else if(model.dashBoardList[index].id == 3){
                                              if(isAdmin){
                                                Navigator.pushNamed(context, RoomScreen.routeName);
                                              }else{
                                                showSnackBar(context);
                                              }

                                            }
                                            else if(model.dashBoardList[index].id == 10){
                                              if(isAdmin){
                                                Navigator.pushNamed(context, SupervisorScreen.routeName);
                                              }else{
                                                showSnackBar(context);
                                              }

                                            }else if(model.dashBoardList[index].id == 4){
                                              if(isAdmin){
                                                Navigator.pushNamed(context, MiniBarScreen.routeName);
                                              }else{
                                                showSnackBar(context);
                                              }
                                            }else if(model.dashBoardList[index].id == 5){
                                              if(isAdmin){
                                                Navigator.pushNamed(context, MiniBarCoScreen.routeName);
                                              }else{
                                                showSnackBar(context);
                                              }
                                            }else if(model.dashBoardList[index].id == 6){
                                              if(isAdmin){
                                                Navigator.pushNamed(context, LaundryScreen.routeName);
                                              }else{
                                                showSnackBar(context);
                                              }
                                            }else if(model.dashBoardList[index].id == 7){
                                              Navigator.pushNamed(context, LostAndFoundScreen.routeName);
                                            }else if(model.dashBoardList[index].id == 8){
                                              Navigator.pushNamed(context, WoEntryScreen.routeName);
                                            }else if(model.dashBoardList[index].id == 9){
                                              if(isAdmin){
                                                Navigator.pushNamed(context, ViewLogsScreen.routeName);
                                              }else{
                                                showSnackBar(context);
                                              }
                                            }
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15)),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  if (model.dashBoardList[index].id == 1)...[
                                                    FaIcon(FontAwesomeIcons.tasks),
                                                  ] else if(model.dashBoardList[index].id == 2)...[
                                                    FaIcon(FontAwesomeIcons.pencilSquare),
                                                  ]
                                                  else if(model.dashBoardList[index].id == 10)...[
                                                      FaIcon(FontAwesomeIcons.pencilSquare),
                                                    ]else if(model.dashBoardList[index].id == 3)...[
                                                    FaIcon(FontAwesomeIcons.building),
                                                  ]else if(model.dashBoardList[index].id == 4)...[
                                                    FaIcon(FontAwesomeIcons.wineGlass),
                                                  ]else if(model.dashBoardList[index].id == 5)...[
                                                    FaIcon(FontAwesomeIcons.wineGlass),
                                                  ]else if(model.dashBoardList[index].id == 6)...[
                                                    Icon( Icons.local_laundry_service_outlined, ),
                                                  ]else if(model.dashBoardList[index].id == 7)...[
                                                    FaIcon(FontAwesomeIcons.folder),
                                                  ]else if(model.dashBoardList[index].id == 8)...[
                                                    FaIcon(FontAwesomeIcons.pencil),
                                                  ]else if(model.dashBoardList[index].id == 9)...[
                                                    FaIcon(FontAwesomeIcons.fileText),
                                                  ],
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(model.dashBoardList[index].name , style: TextStyle(fontWeight: FontWeight.bold ,),)
                                                ],
                                              ),
                                            ),
                                        ),


                                      );
                                    }
                                    )
                                ),
                              ),

                          ),
                ),

                ],
              ),
            );
          },

        ));
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
