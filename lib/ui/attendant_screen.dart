import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:i_clean/models/attendant/ddl_room_status_model.dart';
import 'package:i_clean/models/attendant/floor_response_model.dart';
import 'package:i_clean/models/attendant/guest_status_model.dart';
import 'package:i_clean/models/attendant/maid_status_model.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

class AttendantScreen extends StatefulWidget{
  static const routeName = '/attendant';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AttendantScreenState();
  }

}

class _AttendantScreenState extends State<AttendantScreen> {

  final _formKey = GlobalKey<FormState>();
  String selectedFloor = 'ALL' ;
  String selectGuest = 'ALL';
  String selectedRoom = 'ALL';
  String selectMaid = 'ALL';

  int floorSelectedIndex = 0;
  int guestSelectedIndex = 0;
  int roomSelectedIndex = 0;
  int maidSelectedIndex = 0;
  var pauseController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context , listen: false).getAttendantData(context);
    Provider.of<AppProvider>(context , listen: false).getAttendantList(context , "0" , "ALL" , "ALL" , 'All');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendant'),
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
   /* return  Container(
        height: 220,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Floor Status' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14),),
                  Container(
                    height: 40,
                    width: 100,
                    child: DropdownButton(
                      isExpanded: true,
                      value: floor,
                      hint: Text(model.floorList.first.btnFloor),
                      items: model.floorList?.map((item){
                        return DropdownMenuItem(
                          child: Text(item.btnFloor), //label of item
                          value: item, //value of item
                        );
                      }).toList(),
                      onChanged: ( value){
                        setState(() {
                          floor = value;
                          selectedFloor  = floor.floor.toString();
                        });
                      },
                    ),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Room Status' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14),),
                  Container(
                    height: 40,
                    width: 100,
                    child: DropdownButton(
                      isExpanded: true,
                      value: room,
                      hint: Text(model.roomList.first.roomStatus),
                      items: model.roomList.map((item){
                        return DropdownMenuItem(
                          child: Text(item.roomStatus), //label of item
                          value: item, //value of item
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          room  = value;
                          selectedRoom = room.roomStatus;
                        });
                      },
                    ),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Maid Status' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14),),
                  Container(
                    height: 40,
                    width: 100,
                    child: DropdownButton(
                      isExpanded: true,
                      value: maid,
                      hint: Text(model.maidStatusList.first.maidStatus),
                      items: model.maidStatusList.map((item){
                        return DropdownMenuItem(
                          child: Text(item.maidStatus), //label of item
                          value: item, //value of item
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          maid = value;
                          selectMaid = maid.maidStatus;
                        });
                      },
                    ),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Guest Status' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14),),
                  Container(
                    height: 40,
                    width: 100,
                    child: DropdownButton(
                      isExpanded: true,
                      value: guest,
                      hint: Text(model.guestStatusList.first.status),
                      items: model.guestStatusList.map((item){
                        return DropdownMenuItem(
                          child: Text(item.status), //label of item
                          value: item, //value of item
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          guest = value;
                          selectGuest = guest.status;
                        });
                        //change the country name//get city list.
                      },
                    ),
                  ),

                ],
              ),
              Center(
                child: TextButton(
                  onPressed: (){
                    Provider.of<AppProvider>(context , listen: false).getAttendantList(context , selectedFloor , selectMaid ,
                        selectGuest , selectedRoom);
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),
                  child: Text('Select' , style: TextStyle(color: Colors.black),),
                ),
              )
            ],
          ),
        ),
    );*/

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
                      Provider.of<AppProvider>(context , listen: false).getAttendantList(context ,
                          model.floorList[floorSelectedIndex].floor ,  model.maidStatusList.isEmpty ? "ALL" : model.maidStatusList[maidSelectedIndex].maidStatus , model.guestStatusList[guestSelectedIndex].status , model.roomList[roomSelectedIndex].roomStatus);

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
                      Provider.of<AppProvider>(context , listen: false).getAttendantList(context ,
                          model.floorList[floorSelectedIndex].floor , model.maidStatusList.isEmpty ? "ALL" :model.maidStatusList[maidSelectedIndex].maidStatus , model.guestStatusList[guestSelectedIndex].status , model.roomList[roomSelectedIndex].roomStatus);
                    });
                  },
                  child: Container(
                    width: 80,
                    color: roomSelectedIndex == index   ? Colors.black12
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
              itemCount: model.maidStatusList.length,
              separatorBuilder: (context , index){
                return SizedBox(width: 3,);
              },
              itemBuilder: (context , index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      maidSelectedIndex = index;
                      Provider.of<AppProvider>(context , listen: false).getAttendantList(context ,
                          model.floorList[floorSelectedIndex].floor , model.maidStatusList.isEmpty ? "ALL" : model.maidStatusList[maidSelectedIndex].maidStatus , model.guestStatusList[guestSelectedIndex].status , model.roomList[roomSelectedIndex].roomStatus);
                    });
                  },
                  child: Container(
                    width: 100,
                    color: maidSelectedIndex == index ? Colors.blue :Colors.orange,
                    child: Center(child: Text(model.maidStatusList[index].maidStatus , style: TextStyle(fontWeight: FontWeight.bold),)),
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
                      Provider.of<AppProvider>(context , listen: false).getAttendantList(context ,
                          model.floorList[floorSelectedIndex].floor ,  model.maidStatusList.isEmpty ? "ALL" :model.maidStatusList[maidSelectedIndex].maidStatus , model.guestStatusList[guestSelectedIndex].status , model.roomList[roomSelectedIndex].roomStatus);
                    });
                  },
                  child: Container(
                    width: 80,
                    color: guestSelectedIndex == index ? Colors.black12 :Colors.white,
                    child: Center(child: Text(model.guestStatusList[index].status , style: TextStyle(fontWeight: FontWeight.bold),)),
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
        child: model.state == ViewState.Busy ? Center(child: CircularProgressIndicator(),): model.attendantList.length == 0 ?
        Center(child: Text('No Data' , style: TextStyle(fontSize: 20),),)
        :ListView.builder(
            shrinkWrap: true,
            itemCount: model.attendantList.length,
            itemBuilder: (BuildContext context,int index){
              return Padding(
                padding: EdgeInsets.only(left: 4 ,right: 4 ,top: 2),
                child: Container(
                  height: 200,
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
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('Room# '+model.attendantList[index].unit),
                                  Text('Type :'+ model.attendantList[index].roomType),
                                 Text('LinenChange : '+model.attendantList[index].linenChangeDes),
                                 Text('Connect Room :'+ model.attendantList[index].interconnectRoom),
                                 Text('Room Status : '+model.attendantList[index].roomStatus),
                                 Text('Attendant Status :'+ model.attendantList[index].maidStatus),
                                 Text('Guest Arrived : '+model.attendantList[index].guestArrived),
                                 Text('Guest Status :'+ model.attendantList[index].guestStatus),
                                 Text('Items : '+model.attendantList[index].items),
                                 Text('RA Notes :'+ model.attendantList[index].hmmNotes),
                               ],
                             ),
                           ),
                           Container(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.end,
                               children: [
                                 Visibility(
                                   visible: model.attendantList[index].getRoomDndButton == '' ? false : true,
                                   child: Row(
                                     children: [
                                       Container(
                                         child: FlutterSwitch(
                                           value: model.attendantList[index].getRoomDndButton == 'Disable' ? true : false,
                                           activeColor: Color.fromRGBO(255, 51, 75, 1.0),
                                           inactiveColor: Colors.blue,
                                           onToggle: (value){
                                             showAlertDialogTwo(context, 'Confirm', 'Confirm update "Do Not Distrub status for Room#${model.attendantList[index].unit}', (){
                                               Navigator.pop(context);
                                               Provider.of<AppProvider>(context , listen: false).clickDnd(context , model.attendantList[index].getRoomDndButton.toLowerCase()
                                                   , model.attendantList[index].unit ,'attend');
                                             });
                                            },
                                         ),
                                       ),
                                       Text('DND'),
                                     ],
                                   ),
                                 ),
                                 model.attendantList[index].getStartOrEndTaskButton == 'four' ? _fourButton(model , index):
                                 model.attendantList[index].getStartOrEndTaskButton == 'two'?
                                 _twoButton(model , index) :
                                 Container(
                                 )

                               ],
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

  void showHistorySheet(AppProvider mainModel , BuildContext context, String roomKey) {
    Provider.of<AppProvider>(context ,listen: false).getHistoryLogOfRoom(context ,
        roomKey);
    showModalBottomSheet(context: context,
        builder: (context){
      return Consumer<AppProvider>(
        builder: (context , model , _){
          return model.state == ViewState.Busy ? Center(child: CircularProgressIndicator()):ListView.builder(
              itemCount: model.historyLogItemList.length,
              itemBuilder: (context , index){
                return Padding(
                  padding: EdgeInsets.only(left: 4 , right: 4 ,top: 2),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(model.historyLogItemList[index].getDateTimeToDisplay)),
                  ),
                );
              });
        },
      );
        });
  }

  Widget _fourButton(AppProvider model , int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              ElevatedButton.icon(onPressed: (){
                clickPause(model , index);
              },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue
                ),
                label: const Text('Pause'),
                icon: const Icon(Icons.pause),),
              SizedBox(
                width: 4,
              ),
              ElevatedButton.icon(onPressed: (){
                clickEnd(model , index);
              },  style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent
              ), label: const Text('END'),
                icon: const Icon(Icons.stop),),
            ],
          ),

          ElevatedButton.icon(onPressed: (){
            clickCheckList(model , index);
          },  label: const Text('Attendant Checklist'),
            style: ElevatedButton.styleFrom(
                primary: Colors.green
            ),
            icon: const Icon(Icons.list),),
          ElevatedButton.icon(onPressed: (){
            clickHistory(model , index);
          },  label: const Text('History'),
            icon: const Icon(Icons.history),),
        ],
      ),
    );
  }

  Widget _twoButton(AppProvider model ,int index) {
    return Container(
      child: Row(
        children: [
          Container(
            width:110,
            child: ElevatedButton.icon(onPressed: (){
              showAlertDialogTwo(context,'Are you going to start houskeeping in Room'
                  '${model.attendantList[index].unit}', model.attendantList[index].hmmNotes, (){
                Provider.of<AppProvider>(context ,listen: false).clickStart(context , model.attendantList[index].unit , model.attendantList[index].roomKey);
              Navigator.pop(context);
              });

            },
              style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent
              ),
              label: const Text('Start'),
              icon: const Icon(Icons.play_arrow),),
          ),
          SizedBox(
            width: 4,
          ),
          Container(
            width:110,
            child: ElevatedButton.icon(onPressed: (){
              clickHistory(model , index);

              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange
              ),
              label: const Text('History'),
              icon: const Icon(Icons.history),),
          ),


        ],
      ),
    );
  }

  void clickPause(AppProvider model , int index) {
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title: Text('Are you sure that you want to pause housekeeping in Room: ${model.attendantList[index].unit}'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              autofocus: true,
              controller: pauseController,
              validator: (text){
                if (text == null || text.isEmpty) {
                  return 'Note can\'t be empty';
                }
                return null;
              },

            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  pauseController.clear();
                }, child: Text('CANCEL')),
            TextButton(
                onPressed: (){
                  if (_formKey.currentState.validate()) {

                    model.clickPause(context , model.attendantList[index].unit , pauseController.text , model.attendantList[index].roomKey);
                  }
                }, child: Text('OK')),
          ],
        );
      },
    );
  }

  void clickEnd(AppProvider model , int index) {
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title: Text('Have you completed housekeeping in Room: ${model.attendantList[index].unit}'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              enabled: false,
              autofocus: true,
              controller: pauseController..text = model.attendantList[index].hmmNotes,
              validator: (text){
              },

            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, child: Text('CANCEL')),
            TextButton(
                onPressed: (){
                    model.clickEnd(context , model.attendantList[index].unit ,model.attendantList[index].roomKey);

                }, child: Text('OK')),
          ],
        );
      },
    );
  }

  void clickCheckList(AppProvider model , int index) {
    Provider.of<AppProvider>(context ,listen: false).getCheckList(context ,
        model.attendantList[index].unit);

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (context){
          return FractionallySizedBox(
            child: Consumer<AppProvider>(
              builder: (context , data , _){
                return  Padding(
                  padding: EdgeInsets.all(4),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                          
                            child: model.state == ViewState.Busy ? Center(child: CircularProgressIndicator()) : ListView.builder(
                                itemCount: data.checkItemList.first.attendantCheckList.length,
                                itemBuilder: (context , index){
                                  return Padding(
                                      padding: EdgeInsets.only(left: 4 , right: 4 ,top: 1),
                                      child: Container(
                                        height: 50,
                                        child: Card(
                                          elevation: 2,
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Padding(
                                                      padding: EdgeInsets.all(6),
                                                      child: Text(data.checkItemList.first.attendantCheckList[index].combined)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Padding(
                                                      padding: EdgeInsets.all(6),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: (){
                                                                data.decreaseCheckList(index);

                                                              }, icon: Icon(Icons.indeterminate_check_box_outlined)),
                                                          Center(child: Text(data.checkItemList.first.attendantCheckList[index].quantity.toString() , style: TextStyle(fontSize: 16),)),
                                                          IconButton(
                                                              onPressed: (){
                                                                data.increaseCheckList(index);
                                                                }, icon: Icon(Icons.add_box_outlined)),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),

                                            ],

                                          ),
                                        ),
                                      )
                                  );
                                }),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(onPressed: (){
                                data.updateRoomCheckList(context);
                              }
                                  ,
                                  style:ElevatedButton.styleFrom(primary: Colors.blue)
                                  ,child: Text('OK')),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              }
                                  ,  style:ElevatedButton.styleFrom(primary: Colors.grey) ,
                                  child: Text('CANCEL')),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                );
              },

            ),
          );
        });

  }

  void clickHistory(AppProvider model , int index) {
    showHistorySheet(model , context  ,model.attendantList[index].roomKey);
  }
}