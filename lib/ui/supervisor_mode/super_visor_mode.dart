import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:i_clean/models/supervisor/super_visor_status_response.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/toast_util.dart';

class SupervisorModScreen extends StatefulWidget {
  static const routeName = '/supervisorMod';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SupervisorModScreenState();
  }
}

class _SupervisorModScreenState extends State<SupervisorModScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedFloor = '0';
  String selectedRoom = 'ALL';
  String selectedStaff = '' ;
  String selectedMaidStatus = 'ALL';
  int currentPage = 1;
  StaffList mStaff;
  int floorSelectedIndex = 0;
  int roomSelectedIndex = 0;
  int maidStatusSelectedIndex = 0;
  var confirmTextController = TextEditingController();
  String phy  ='';
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context, listen: false).getSupervisorModData(context);
    Provider.of<AppProvider>(context, listen: false)
        .getSupervisorModeGrid(context, selectedRoom, selectedFloor , selectedStaff , selectedMaidStatus , currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Supervisor Mode'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, model, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              model.superVisorRoomList.isEmpty ? Container():
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
                          .getSupervisorModeGrid(
                          context,
                          model.superVisorRoomList[roomSelectedIndex]
                              .roomStatus,
                          model.superVisorFloorList[floorSelectedIndex]
                              .floor ,
                          selectedStaff,
                        model.maidStatusCountList[maidStatusSelectedIndex].maidStatus,
                        1
                      );
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
                          .getSupervisorModeGrid(
                          context,
                          model.superVisorRoomList[roomSelectedIndex]
                              .roomStatus,
                          model.superVisorFloorList[floorSelectedIndex]
                              .floor ,
                          selectedStaff,
                          model.maidStatusCountList[maidStatusSelectedIndex].maidStatus,
                          1
                      );
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
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 12),
              width: 150,
              child: DropdownButton(
                isExpanded: true,
                value: mStaff,
                hint: Text(model.staffList.first.name),
                items: model.staffList.map((item){
                  return DropdownMenuItem(
                    child: Text(item.name), //label of item
                    value: item, //value of item
                  );
                }).toList(),
                onChanged: ( value){
                  setState(() {
                    mStaff = value;
                    selectedStaff = mStaff.maidKey;
                    Provider.of<AppProvider>(context, listen: false)
                        .getSupervisorModeGrid(
                        context,
                        model.superVisorRoomList[roomSelectedIndex]
                            .roomStatus,
                        model.superVisorFloorList[floorSelectedIndex]
                            .floor ,
                        selectedStaff,
                        model.maidStatusCountList[maidStatusSelectedIndex].maidStatus,
                        1
                    );
                  });
                },
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(6),
              itemCount: model.maidStatusCountList.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 3,
                );
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      maidStatusSelectedIndex = index;
                      Provider.of<AppProvider>(context, listen: false)
                          .getSupervisorModeGrid(
                          context,
                          model.superVisorRoomList[roomSelectedIndex]
                              .roomStatus,
                          model.superVisorFloorList[floorSelectedIndex]
                              .floor ,
                          selectedStaff,
                          model.maidStatusCountList[maidStatusSelectedIndex].maidStatus,
                          1
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: maidStatusSelectedIndex == index
                            ? Colors.grey
                            : model.maidStatusCountList[index].maidStatus == 'Clean' ? Color(0xFF5cb85c)
                            :model.maidStatusCountList[index].maidStatus == 'Dirty' ? Color(0xFFff2e2e)
                            : Colors.transparent,
                        border: Border.all(
                          color: model.maidStatusCountList[index].maidStatus == 'ALL'
                              ? Colors.grey
                              : model.maidStatusCountList[index].maidStatus == 'Clean' ? Color(0xFF5cb85c)
                              :model.maidStatusCountList[index].maidStatus == 'Dirty' ? Color(0xFFff2e2e)
                              : Colors.grey,
                          width: 2,
                        )),
                    width: 80,
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
            : model.supervisorModeList.length == 0
            ? Center(
          child: Text(
            'No Data',
            style: TextStyle(fontSize: 20),
          ),
        )
            : SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: false,
          physics: BouncingScrollPhysics(),
          footer: CustomFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            builder:
                (BuildContext context, LoadStatus mode) {
              Widget body;
              mode == LoadStatus.noMore
                  ? body = Text('')
                  : body = CircularProgressIndicator();
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          onRefresh: () async {
            await Future.delayed(
                Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
            await Future.delayed(
                Duration(milliseconds: 1000));
            if (model.totalCount == model.supervisorModeList.length) {
              _refreshController.loadNoData();
              ToastUtil.showToast('No more products');
            } else {
              currentPage++;
              fetchSupervisorModeGrid();
            }
            _refreshController.loadComplete();
          },
              child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.supervisorModeList.length,
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
                                width: MediaQuery.of(context).size.width/2.25,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Name : ' +
                                            model.supervisorModeList[index]
                                                .maid),
                                        Text(model.supervisorModeList[index]
                                            .getGuestArrived),
                                        Container(
                                          color: Colors.blue,
                                          child: Text(
                                              model.supervisorModeList[index]
                                                  .preCheckInCountDes , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),

                                    Text('Room# ' +
                                        model.supervisorModeList[index]
                                            .unit),
                                    Text('Type :' +
                                        model.supervisorModeList[index]
                                            .roomType),
                                    Text('LinenChange : ' +
                                        model.supervisorModeList[index]
                                            .linenChangeDes),
                                    Text('Connect Room :' +
                                        model.supervisorModeList[index]
                                            .interconnectRoom),
                                    Text('Room Status : ' +
                                        model.supervisorModeList[index]
                                            .roomStatus),
                                    Text('Attendant Status : ' +
                                        model.supervisorModeList[index]
                                            .maidStatus),
                                    Text('Guest Arrived : ' +
                                        model.supervisorModeList[index]
                                            .guestArrived),
                                    Text('Notes : ' +
                                        model.supervisorModeList[index]
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
                                      model.supervisorModeList[index]
                                          .getRoomDndButton ==
                                          ''
                                          ? false
                                          : true,
                                      child: Row(
                                        children: [
                                          Container(
                                            child: FlutterSwitch(
                                              value: model
                                                  .supervisorModeList[
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
                                                    'Confirm update "Do Not disturb status for Room#${model.supervisorModeList[index].unit}',
                                                        () {
                                                      Navigator.pop(context);
                                                      Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                          .clickDnd(
                                                          context,
                                                          model
                                                              .supervisorModeList[
                                                          index]
                                                              .getRoomDndButton
                                                              .toLowerCase(),
                                                          model
                                                              .supervisorModeList[
                                                          index]
                                                              .unit , 'mode');
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
                                            .supervisorModeList[
                                        index]
                                            .getRoomCleanButton ==
                                            ''
                                            ? false
                                            : true,
                                        child: Row(
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                showConfirmDialog(model.supervisorModeList[index].unit , model.supervisorModeList[index].roomKey ,'Clean');

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
                                               // clickDirty(model, index);
                                                showConfirmDialog(model.supervisorModeList[index].unit, model.supervisorModeList[index].roomKey , 'Dirty');

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
                                      visible:
                                      model.supervisorModeList[index]
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
              return model.state == ViewState.Busy ? Center(child: CircularProgressIndicator(),) :
              model.supervisorHistoryList.isEmpty ?
              Center(child: Text('There is no history.'),) :ListView.builder(
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


  void clickHistory(AppProvider model, int index) {
    showHistorySheet(model, context, model.supervisorModeList[index].roomKey);
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
                      Provider.of<AppProvider>(context , listen: false).confirmCleanMode(context, room,
                          confirmTextController.text , phy , roomKey);

                    }else{
                      Provider.of<AppProvider>(context , listen: false).confirmDirtyMode(context, room,
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

  void fetchSupervisorModeGrid() {
    Provider.of<AppProvider>(context, listen: false)
        .getSupervisorModeGrid(context, selectedRoom, selectedFloor , selectedStaff , selectedMaidStatus , currentPage);

  }


}
