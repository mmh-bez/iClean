import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:i_clean/models/attendant/ddl_room_status_model.dart';
import 'package:i_clean/models/attendant/floor_response_model.dart';
import 'package:i_clean/models/attendant/guest_status_model.dart';
import 'package:i_clean/models/attendant/maid_status_model.dart';
import 'package:i_clean/models/room/room_popup_response.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

class RoomScreen extends StatefulWidget{
  static const routeName = '/roomScreen';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RoomScreenState();
  }

}

class _RoomScreenState extends State<RoomScreen> {

  final _formKey = GlobalKey<FormState>();
  String selectedFloor = 'ALL' ;
  String selectGuest = 'ALL';
  String selectedRoom = 'ALL';

  int floorSelectedIndex = 0;
  int guestSelectedIndex = 0;
  int roomSelectedIndex = 0;
  int maidSelectedIndex = 0;
  var pauseController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context , listen: false).getRoomData(context);
    Provider.of<AppProvider>(context , listen: false).getRoomList(context ,  "ALL" ,selectGuest, "0");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Room'),
      ),
      body: Consumer<AppProvider>(
        builder: (context , model , _){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StatusWidget(model),
              _StatusListRoom(model),
            ],
          );
        },
      ),
    );
  }

  Widget _StatusWidget(AppProvider model) {

    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(6),
              itemCount: model.floorList.length,
              separatorBuilder: (context , index){
                return SizedBox(width: 3,);
              },
              itemBuilder: (context , index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      floorSelectedIndex = index;
                      Provider.of<AppProvider>(context , listen: false).getRoomList(context ,
                          model.roomList[roomSelectedIndex].roomStatus,model.guestStatusList[guestSelectedIndex].status,model.floorList[floorSelectedIndex].floor );

                    });
                  },
                  child: Container(
                    width: 60,
                    color: floorSelectedIndex == index ? Colors.blue :Colors.orange,
                    child: Center(child: Text(model.floorList[index].btnFloor , style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 6,
          ),  Container(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(6),
              itemCount: model.roomList.length,
              separatorBuilder: (context , index){
                return SizedBox(width: 3,);
              },
              itemBuilder: (context , index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      roomSelectedIndex = index;
                      Provider.of<AppProvider>(context , listen: false).getRoomList(context ,
                          model.roomList[roomSelectedIndex].roomStatus,model.guestStatusList[guestSelectedIndex].status , model.floorList[floorSelectedIndex].floor );
                    });
                  },
                  child: Container(
                    width: 80,
                    color: roomSelectedIndex == index ? Colors.black12
                        : model.roomList[index].roomStatus == 'Vacant' ? Color(0xFF5cb85c)
                        :model.roomList[index].roomStatus == 'Out Of Order' ? Color(0xFF5bc0de)
                        :model.roomList[index].roomStatus == 'Occupied' ? Color(0xFFFFc0cb)
                        :model.roomList[index].roomStatus == 'Due Out' ? Color(0xFFff2e2e)
                        : model.roomList[index].roomStatus == 'Hold' ? Color(0xFF31b0d5)
                        : Colors.grey,
                    child: Center(child: Text(model.roomList[index].roomStatus , style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            height: 6,
          ),  Container(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(6),
              itemCount: model.guestStatusList.length,
              separatorBuilder: (context , index){
                return SizedBox(width: 3,);
              },
              itemBuilder: (context , index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      guestSelectedIndex = index;
                      Provider.of<AppProvider>(context , listen: false).getRoomList(context ,
                           model.roomList[roomSelectedIndex].roomStatus,model.guestStatusList[guestSelectedIndex].status , model.floorList[floorSelectedIndex].floor  );
                    });
                  },
                  child: Container(
                    width: 80,
                    color: guestSelectedIndex == index ? Colors.blueGrey : Color(0xFFd3a458),
                    child: Center(child: Text(model.guestStatusList[index].status , style: TextStyle(fontWeight: FontWeight.bold , color: guestSelectedIndex == index ? Colors.white : Colors.black54),)),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _StatusListRoom(AppProvider model) {
    return Expanded(
      child: Container(
        child: model.state == ViewState.Busy ? Center(child: CircularProgressIndicator(),): model.roomGridList.length == 0 ?
        Center(child: Text('No Data' , style: TextStyle(fontSize: 20),),)
            :GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio:1.4,
                crossAxisSpacing: 1,
                mainAxisSpacing: 4),
            itemCount: model.roomGridList.length,
            itemBuilder: (BuildContext context,int index){
              return Padding(
                padding: EdgeInsets.only(left: 4 ,right: 4 ,top: 2),
                child: Container(
                  height: 160,
                  child: Card(
                    elevation: 2,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.roomGridList[index].unit),
                                  Text( model.roomGridList[index].roomType),
                                  Text(model.roomGridList[index].roomStatus),
                                  Text( model.roomGridList[index].maidStatus),
                                  model.roomGridList[index].guestDes == null ?
                                  Visibility(
                                      visible: false,
                                      child: Text("")) :
                                  Text(model.roomGridList[index].guestDes , maxLines: 2,),
                                  model.roomGridList[index].maidDes == null ?
                                  IconButton(onPressed: (){
                                    showAssignPopup(context ,  model.roomGridList[index].unit);
                                  }, icon: Icon(Icons.more_horiz)) :
                                      TextButton(onPressed: (){
                                        showAssignPopup(context ,  model.roomGridList[index].unit);
                                      }, child: Text(model.roomGridList[index].maidDes)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Visibility(
                                visible: model.roomGridList[index].dndStatus == '-' ? false : true,
                                child: Container(
                                  child: FlutterSwitch(
                                    value: model.roomGridList[index].dndStatus == 'Disable' ? true : false,
                                  activeColor: Color.fromRGBO(255, 51, 75, 1.0),
                                  inactiveColor: Colors.blue,
                                  onToggle: (value){
                                    showAlertDialogTwo(context, 'Confirm', 'Confirm update "Do Not disturb status for Room#${model.roomGridList[index].unit}', (){
                                      Navigator.pop(context);
                                      Provider.of<AppProvider>(context , listen: false).clickDnd(context , model.roomGridList[index].dndStatus.toLowerCase()
                                          , model.roomGridList[index].unit ,'room');
                                    });
                                  },
                                ),
                    ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void showAssignPopup(BuildContext context ,  String roomNo) {
    RoomPopUpItemList _roomPopUpItemList;
    Provider.of<AppProvider>(context , listen: false).getRoomPopup(context , roomNo);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context , StateSetter setState){
            return Consumer<AppProvider>(
              builder: (context , data , _){
                return data.mRoomPopupItem == null ? CircularProgressIndicator() : AlertDialog(
      title:  Text.rich(
                TextSpan(
                children: [
                TextSpan(text: 'Room$roomNo is assigned to '  , style: TextStyle(color: Colors.blue)),
                  TextSpan(text: data.mRoomPopupItem.previousAttendantName  , style: TextStyle(color: Colors.orange)),
                  data.mRoomPopupItem.previousAttendantName == "none" ? TextSpan(text: '' ) :
                  WidgetSpan(child: InkWell(
                      onTap: (){
                        Provider.of<AppProvider>(context , listen: false).clickUnassign(context, data.mRoomPopupItem.previousAttendantKey , roomNo , data.mRoomPopupItem.previousAttendantName );
                      },
                      child: Icon(Icons.person_remove_rounded , color: Colors.red,))),
                ],
                ),
                ),
                  content: Container(
                    height: 100,
                    width: 200,
                    child: Column(
                      children: <Widget>[
                        Text("Assign/Re-assign To"),
                        DropdownButton<RoomPopUpItemList>(
                          value: _roomPopUpItemList,
                          underline: Container(),
                          items: data.roomPopUpItemList.map((RoomPopUpItemList selected ) {
                            return DropdownMenuItem<RoomPopUpItemList>(
                              value: selected,
                              child: Text(selected.name),
                            );
                          }).toList(),
                          onChanged: ( value) {
                            setState(() {
                              _roomPopUpItemList = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(onPressed: (){
                      data.mRoomPopupItem.previousAttendantName == "none" ?
                      Provider.of<AppProvider>(context , listen: false).addAssign(context ,"", _roomPopUpItemList.maidKey ,
                          _roomPopUpItemList.name , roomNo ,  "none")
                          :
                      Provider.of<AppProvider>(context , listen: false).addAssign(context , data.mRoomPopupItem.previousAttendantKey, _roomPopUpItemList.maidKey ,
                          _roomPopUpItemList.name , roomNo , data.mRoomPopupItem.previousAttendantName);
                      Navigator.pop(context);
                    }, child: Text('Assign')),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel'))


                  ],
                );
              },
            );
          },
        );
  },
  );
  }

}