import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:i_clean/models/supervisor/super_visor_status_response.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

class SupervisorScreen extends StatefulWidget {
  static const routeName = '/supervisor';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SupervisorScreenState();
  }
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedFloor = 'ALL';
  String selectedRoom = 'ALL';
  String selectedStaff = '' ;
  StaffList mStaff;
  int floorSelectedIndex = 0;
  int roomSelectedIndex = 0;
  var confirmTextController = TextEditingController();
  String phy  ='';

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context, listen: false).getSupervisorData(context);
    Provider.of<AppProvider>(context, listen: false)
        .getSupervisorGrid(context, selectedRoom, "0" , selectedStaff);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Supervisor'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, model, _) {
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
              itemCount: model.superVisorFloorList.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 3,
                );
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      floorSelectedIndex = index;
                      Provider.of<AppProvider>(context, listen: false)
                          .getSupervisorGrid(
                              context,
                              model.superVisorRoomList[roomSelectedIndex]
                                  .roomStatus,
                              model.superVisorFloorList[floorSelectedIndex]
                                  .floor ,
                      selectedStaff);
                    });
                  },
                  child: Container(
                    width: 60,
                    color: floorSelectedIndex == index
                        ? Colors.blue
                        : Colors.orange,
                    child: Center(
                        child: Text(
                      model.superVisorFloorList[index].btnFloor,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(6),
              itemCount: model.superVisorRoomList.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 3,
                );
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      roomSelectedIndex = index;
                      Provider.of<AppProvider>(context, listen: false)
                          .getSupervisorGrid(
                              context,
                              model.superVisorRoomList[roomSelectedIndex]
                                  .roomStatus,
                              model.superVisorFloorList[floorSelectedIndex]
                                  .floor ,
                      selectedStaff);
                    });
                  },
                  child: Container(
                    width: 80,
                    color: roomSelectedIndex == index
                        ? Colors.black12
                        : model.superVisorRoomList[index].roomStatus == 'Vacant' ? Color(0xFF5cb85c)
                        :model.superVisorRoomList[index].roomStatus == 'Out Of Order' ? Color(0xFF5bc0de)
                        :model.superVisorRoomList[index].roomStatus == 'Occupied' ? Color(0xFFFFc0cb)
                        :model.superVisorRoomList[index].roomStatus == 'Due Out' ? Color(0xFFff2e2e)
                        : model.superVisorRoomList[index].roomStatus == 'Hold' ? Color(0xFF31b0d5)
                        : Colors.grey,

                    child: Center(
                        child: Text(
                      model.superVisorRoomList[index].roomStatus,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            width: 150,
            child: DropdownButton(
              isExpanded: true,
              value: mStaff,
              hint: Text('All'),
              items: model.staffList.map((item){
                return DropdownMenuItem(
                  child: Text(item.name), //label of item
                  value: item, //value of item
                );
              }).toList(),
              onChanged: ( value){
                setState(() {
                  mStaff = value;
                  selectedStaff = value.maidKey;
                  Provider.of<AppProvider>(context, listen: false)
                      .getSupervisorGrid(
                      context,
                      model.superVisorRoomList[roomSelectedIndex]
                          .roomStatus,
                      model.superVisorFloorList[floorSelectedIndex]
                          .floor ,
                      selectedStaff);
                });
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
        child: model.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.supervisorItemList.length == 0
                ? Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.supervisorItemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 4, right: 4, top: 2),
                        child: Container(
                          height: 200,
                          child: Card(
                            elevation: 2,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Name : ' +
                                              model.supervisorItemList[index]
                                                  .maid),
                                          Text('Room# ' +
                                              model.supervisorItemList[index]
                                                  .unit),
                                          Text('Type :' +
                                              model.supervisorItemList[index]
                                                  .roomType),
                                          Text('LinenChange : ' +
                                              model.supervisorItemList[index]
                                                  .linenChangeDes),
                                          Text('Connect Room :' +
                                              model.supervisorItemList[index]
                                                  .interconnectRoom),
                                          Text('Room Status : ' +
                                              model.supervisorItemList[index]
                                                  .roomStatus),
                                          Text('Guest Arrived : ' +
                                              model.supervisorItemList[index]
                                                  .guestArrived),
                                          Text('RA Notes : ' +
                                              model.supervisorItemList[index]
                                                  .hmmNotes),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Visibility(
                                            visible:
                                                model.supervisorItemList[index]
                                                            .getRoomDndButton ==
                                                        ''
                                                    ? false
                                                    : true,
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: FlutterSwitch(
                                                    value: model
                                                                .supervisorItemList[
                                                                    index]
                                                                .getRoomDndButton ==
                                                            'Disable'
                                                        ? true
                                                        : false,
                                                    activeColor: Color.fromRGBO(
                                                        255, 51, 75, 1.0),
                                                    inactiveColor: Colors.blue,
                                                    onToggle: (value) {
                                                      showAlertDialogTwo(
                                                          context,
                                                          'Confirm',
                                                          'Confirm update "Do Not Distrub status for Room#${model.supervisorItemList[index].unit}',
                                                          () {
                                                        Navigator.pop(context);
                                                        Provider.of<AppProvider>(
                                                                context,
                                                                listen: false)
                                                            .clickDnd(
                                                                context,
                                                                model
                                                                    .supervisorItemList[
                                                                        index]
                                                                    .getRoomDndButton
                                                                    .toLowerCase(),
                                                                model
                                                                    .supervisorItemList[
                                                                        index]
                                                                    .unit , 'super');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Text('DND'),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                              visible: model
                                                          .supervisorItemList[
                                                              index]
                                                          .getRoomCleanButton ==
                                                      ''
                                                  ? false
                                                  : true,
                                              child: Row(
                                                children: [
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      clickClean(model, index);
                                                    },
                                                    label: const Text('Clean'),
                                                    icon: const Icon(
                                                        Icons.thumb_up),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.green),
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      clickDirty(model, index);
                                                    },
                                                    label: const Text('Dirty'),
                                                    icon: const Icon(
                                                        Icons.thumb_down),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                  ),
                                                ],
                                              )),
                                          Visibility(
                                            visible: model
                                                        .supervisorItemList[
                                                            index]
                                                        .getLinenItemButton ==
                                                    ''
                                                ? false
                                                : true,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                clickCheckList(model.supervisorItemList[index].unit );
                                              },
                                              label: const Text('Supervisor Checklist'),
                                              icon: const Icon(Icons.list_alt),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.lightBlue),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                model.supervisorItemList[index]
                                                            .getHistoryLog ==
                                                        ''
                                                    ? false
                                                    : true,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                clickHistory(model, index);
                                              },
                                              label: const Text('History'),
                                              icon: const Icon(Icons.history),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.orangeAccent),
                                            ),
                                          ),
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

  void showHistorySheet(
      AppProvider mainModel, BuildContext context, String roomKey) {
    Provider.of<AppProvider>(context, listen: false)
        .getHistorySupervisor(context, roomKey);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Consumer<AppProvider>(
            builder: (context, model, _) {
              return model.state == ViewState.Busy ? Center(child: CircularProgressIndicator(),) :ListView.builder(
                  itemCount: model.supervisorHistoryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 4, right: 4, top: 2),
                      child: Card(
                        elevation: 2,
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Text(model.supervisorHistoryList[index]
                                .getDateTimeToDisplay)),
                      ),
                    );
                  });
            },
          );
        });
  }

  void clickCheckList(String room) {
    Provider.of<AppProvider>(context, listen: false)
        .getSupervisorCheckList(context, room);

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 1,
            child: Consumer<AppProvider>(
              builder: (context , model , _){
                return   Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 550,
                        child: model.state == ViewState.Busy ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                            itemCount:
                            model.supCheckItemList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding:
                                  EdgeInsets.only(left: 4, right: 4, top: 2),
                                  child: Container(
                                    height: 50,
                                    child: Card(
                                      elevation: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 400,
                                            child: Padding(
                                                padding: EdgeInsets.all(6),
                                                child: Text(model
                                                    .supCheckItemList[index].combined)),
                                          ),
                                          Container(
                                            child: Padding(
                                                padding: EdgeInsets.all(6),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                        child: Text(model
                                                            .supCheckItemList[index].quantity)),
                                                  ],
                                                )),
                                          ),
                                      Checkbox(
                                          value: model.supCheckItemList[index].checked == 0 ? false : true,
                                          onChanged: (value){
                                            model.updateCheckbox( value , index);


                                          }
                                      ),
                                        ],
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () {
                            model.saveCheckList(context);
                          }, child: Text('OK')),
                          SizedBox(
                            width: 2,
                          ),
                          ElevatedButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: Text('CANCEL')),
                        ],
                      )
                    ],
                  ),
                );
              },

            ),
          );
        });
  }

  void clickHistory(AppProvider model, int index) {
    showHistorySheet(model, context, model.supervisorItemList[index].roomKey);
  }

  void clickClean(AppProvider model, int index) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Physical Inspection for Room :  ${model.supervisorItemList[index].unit} \ ?'),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  phy = "phy";
                });
                Navigator.pop(context);
                showConfirmDialog(model.supervisorItemList[index].unit , model.supervisorItemList[index].roomKey , 'Clean');
              },
              label: const Text('YES'),
              icon: const Icon(
                  Icons.thumb_up),
              style: ElevatedButton
                  .styleFrom(
                  primary:
                  Colors.green),
            ),
            SizedBox(
              width: 4,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  phy = 'Nophy';
                });
                Navigator.pop(context);
                showConfirmDialog(model.supervisorItemList[index].unit , model.supervisorItemList[index].roomKey ,'Clean');
              },
              label: const Text('NO'),
              icon: const Icon(
                  Icons.thumb_down),
              style: ElevatedButton
                  .styleFrom(
                  primary:
                  Colors.red),
            ),
          ],
        );
      },
    );
  }

  void clickDirty(AppProvider model, int index) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Physical Inspection for Room :  ${model.supervisorItemList[index].unit} \ ?'),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  phy = "phy";
                });
                Navigator.pop(context);
                showConfirmDialog(model.supervisorItemList[index].unit , model.supervisorItemList[index].roomKey, 'Dirty');
              },
              label: const Text('YES'),
              icon: const Icon(
                  Icons.thumb_up),
              style: ElevatedButton
                  .styleFrom(
                  primary:
                  Colors.green),
            ),
            SizedBox(
              width: 4,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  phy = 'Nophy';
                });
                Navigator.pop(context);
                showConfirmDialog(model.supervisorItemList[index].unit, model.supervisorItemList[index].roomKey , 'Dirty');
              },
              label: const Text('NO'),
              icon: const Icon(
                  Icons.thumb_down),
              style: ElevatedButton
                  .styleFrom(
                  primary:
                  Colors.red),
            ),
          ],
        );
      },
    );
  }

  void showConfirmDialog(String room , String roomKey , String type) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Are you sure that you want to update Room: ${room} status as $type'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              autofocus: true,
              controller: confirmTextController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Note can\'t be empty';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  confirmTextController.clear();
                },
                child: Text('Close')),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if(type == 'Clean'){
                      Provider.of<AppProvider>(context , listen: false).confirmClean(context, room,
                          confirmTextController.text , phy , roomKey);

                    }else{
                      Provider.of<AppProvider>(context , listen: false).confirmDirty(context, room,
                          confirmTextController.text , phy , roomKey );

                    }

                  }
                },
                child: Text(type)),
          ],
        );
      },
    );
  }


}
