import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_clean/models/attendant/attendant_data_model.dart';
import 'package:i_clean/models/attendant/attendant_model.dart';
import 'package:i_clean/models/attendant/check_list_model.dart';
import 'package:i_clean/models/attendant/ddl_room_status_model.dart';
import 'package:i_clean/models/attendant/floor_response_model.dart';
import 'package:i_clean/models/attendant/guest_status_model.dart';
import 'package:i_clean/models/attendant/history_log_of_room.dart';
import 'package:i_clean/models/attendant/maid_status_model.dart';
import 'package:i_clean/models/base_response_token.dart';
import 'package:i_clean/models/dash_board_model.dart';
import 'package:i_clean/models/history_model.dart';
import 'package:i_clean/models/laundry/laundry_item_response.dart';
import 'package:i_clean/models/login_model.dart';
import 'package:i_clean/models/lost_found/LostAndFoundDataModel.dart';
import 'package:i_clean/models/lost_found/lost_and_found_edit_response.dart';
import 'package:i_clean/models/lost_found/lost_found_model.dart';
import 'package:i_clean/models/base_response.dart';
import 'package:i_clean/models/minibar/minibar_item_response.dart';
import 'package:i_clean/models/post_selected_item.dart';
import 'package:i_clean/models/room/room_grid_response.dart';
import 'package:i_clean/models/room/room_popup_response.dart';
import 'package:i_clean/models/room/room_status_response.dart';
import 'package:i_clean/models/room_button.dart';
import 'package:i_clean/models/select_item_model.dart';
import 'package:i_clean/models/supervisor/super_visor_checklist_response.dart';
import 'package:i_clean/models/supervisor/super_visor_grid_response.dart';
import 'package:i_clean/models/supervisor/super_visor_status_response.dart';
import 'package:i_clean/models/supervisormode/supervisor_mode_data.dart';
import 'package:i_clean/models/view_logs_response.dart';
import 'package:i_clean/models/woentry/wo_entry_model.dart';
import 'package:i_clean/models/task_model.dart';
import 'package:i_clean/providers/base_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:i_clean/service/api_service.dart';
import 'package:i_clean/ui/dash_board.dart';

import '../models/floor_model.dart';
import '../models/supervisormode/supervisor_mode_grid_data.dart';
import '../ui/dashboard_screen.dart';
import '../utils/const.dart';

class AppProvider extends BaseProvider{
  int totalCount = 0;
  int assignedTask = 0;
  int inspectRoom = 0;
  String currentFloorName = '';
  String currentMaidStatus = '';
  String currentGuestStatus = '';
  String currentRoomStatus = '';

  List<DashBoardModel> dashBoardList = [];

  List<GetRoomStatuss> roomList = [];
  List<GetHotelFloor> floorList = [];
  List<MaidStatusListOutPut> maidStatusList = [];
  List<GetGuestStatuss> guestStatusList =[];
  List<AttendantItem> attendantList = [];

  //Woentry
  List<GetReportedBy> reportedByList = [];
  List<Room> lostFoundRoomList = [];
  List<Area> areaList = [];
  List<WorkType> workTypeList = [];
  //=======////

  List<LostAndFoundItem> lostAndFoundItemList = [];

  //Lostandfound
  List<LFItemStatus> lfItemList = [];
  List<LFRoom> lfRoomList = [];
  List<LFArea> lfAreaList = [];

  List<RoomButtonItem> miniBarRoomList =[];
  List<RoomButtonItem> laundryRoomList =[];
  List<RoomButtonItem> miniBarCoRoomList =[];


  List<GetHotelFloor> miniBarFloorList = [];
  List<GetHotelFloor> miniBarCoFloorList = [];
  List<GetHotelFloor> laundryFloorList = [];

  List<HistoryItem> historyList =[];
  List<ViewLogItem> viewLogList = [];

  //AddLaundry
  List<LaundryItemModel> laundryItemModelList =[];
  List<ItemSelected> tempItemSelectedList = [];
  List<MinibarItemModel> minibarItemList = [];
  List<MinibarItemModel> minibarCoItemList = [];
  LostFoundEditData lostFoundEditData;

  List<HistoryLogOfRoomItem> historyLogItemList =[];
  List<CheckListItem> checkItemList = [];

  List<RoomGridItems> roomGridList =[];

  var qty = 0;
  var selectedQty = 1;

  List<RoomPopUpItemList> roomPopUpItemList = [];
  RoomPopUpItem mRoomPopupItem;

  String roomPopupStatus;
  String roomFloor;
  String guestStatus;

  List<GetHotelFloor> superVisorFloorList =[];
  List<StaffList> staffList =[];
  List<GetRoomStatuss> superVisorRoomList = [];
  List<MaidStatusCount> maidStatusCountList=[];

  void login(BuildContext context , String id , String pin) async{
    showLoaderDialog(context);
    LoginModel loginModel = await ApiService.login(context ,id ,  pin);
    if( loginModel.success){
      Navigator.pop(context);
      token = loginModel.result.accessToken;
      staffKey = loginModel.result.staffKey;
      name = loginModel.result.name;
      isAdmin = loginModel.result.isAdmin;
      await FirebaseMessaging.instance.getToken().then((token) {
        print('-------'+token);
        ApiService.addFirebaseToken(context , token);
      });
      Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (Route<dynamic> route) => false);
    }else{
      Navigator.pop(context);
     showAlertDialog(context, "Wrong", "Invalid PIN", (){
      // Navigator.pop(context);

     });
    }
    notifyListeners();
  }


  void getDashBoard(BuildContext context)async{
    var jsondata = await rootBundle.loadString('assets/dashboard.json');
    dashBoardList = dashBoardModelFromJson(jsondata);
    notifyListeners();
  }

  void getDashBoardData(BuildContext context) async{
    TaskModel _task = await ApiService.getTask(context);
    assignedTask = _task.result.items.first.assignedTask;
    inspectRoom = _task.result.items.first.roomToInspect;
    notifyListeners();
  }


  void getAttendantData(BuildContext context)async{
    floorList.clear();
    roomList.clear();
    maidStatusList.clear();
    guestStatusList.clear();
    setState(ViewState.Busy);
    AttendantDataModel _attendantDataModel = await ApiService.getAttendantData(context);
    if(_attendantDataModel.success ){
      setState(ViewState.Idle);
      floorList.add(GetHotelFloor(floor: '0' , btnFloor: 'ALL'));
      roomList.add(GetRoomStatuss(roomStatusKey : "",
          roomStatus: "ALL"));
      guestStatusList.add(GetGuestStatuss(guestStatusKey: '' ,
          statusCode: 0 , status: 'ALL'));
      floorList.addAll(_attendantDataModel.result.items.first.getHotelFloors);
      roomList.addAll(_attendantDataModel.result.items.first.getRoomStatuss);
      maidStatusList.addAll(_attendantDataModel.result.items.first.maidStatusListOutPuts);
      guestStatusList.addAll(_attendantDataModel.result.items.first.getGuestStatuss);

    }else{
      setState(ViewState.Idle);
      showAlertDialog(context, "Error", "Something Wrong.Please try again", (){

      });
    }

    notifyListeners();
  }

  void getAttendantList(BuildContext context, String floorName, String maidStatus, String guestStatus, String roomStatus)async {
    setState(ViewState.Busy);
    currentFloorName = floorName;
    currentMaidStatus = maidStatus;
    currentGuestStatus = guestStatus;
    currentRoomStatus = roomStatus;

    AttendantModel _attendantModel = await ApiService.getAttendantList(
        context, floorName, maidStatus, guestStatus, roomStatus);
    if(_attendantModel.success == true) {
      setState(ViewState.Idle);
      attendantList = _attendantModel.result.items;

    }
    notifyListeners();
  }

  void getWoEntryData(BuildContext context)async{

    WoEntryDataModel _woEntry = await ApiService.getWoEntryData(context);
    if(_woEntry.success == true) {
      reportedByList = _woEntry.result.items.first.getReportedBy;
      lostFoundRoomList = _woEntry.result.items.first.room;
      areaList = _woEntry.result.items.first.area ;
      workTypeList = _woEntry.result.items.first.workType;
    }
    notifyListeners();

  }

  void addWorkOrder(BuildContext context , String date , String areaDesc , String workTypeDesc
      , String description , String note,String room , String roomKey , int area , int workType , String staffKey , String mode , String staffName) async{

    showLoaderDialog(context);
    Map<String , dynamic> dataMap = {
      "reportedOn": date,
      "mAreaDesc": areaDesc,
      "mWorkTypeDesc": workTypeDesc,
      "description": description,
      "notes": note,
      "room": room,
      "roomKey": roomKey,
      "mArea": area,
      "mWorkType": workType,
      "SelectedStaffKey":staffKey,
      "mode":mode,
      "StaffName": staffName
    };

    BaseResponse _addWorkType = await ApiService.addWorkOrder(context , dataMap);
    if(_addWorkType.success == true){
      Navigator.pop(context);
      showAlertDialog(context, "Success", "Your order is success",(){
        Navigator.pop(context);
       // Navigator.pop(context);
      });
    }else{
      showAlertDialog(context, "Error", "Your order is not success.Please try again.",  (){
        Navigator.pop(context);
      });
    }
  }

  void getLostFoundData(BuildContext context) async{
    setState(ViewState.Busy);
    LostAndFoundData _lostFound = await ApiService.getLostAndFoundData(context);
    if(_lostFound.success == true){
      setState(ViewState.Idle);
      lostAndFoundItemList = _lostFound.result.items ;
    }

    notifyListeners();
  }

  void getLostFoundDataModel(BuildContext context)async{
    setState(ViewState.Busy);
    LostAndFoundDataModel _model = await ApiService.getLostAndFoundDataModel(context);
    if(_model.success == true) {
      setState(ViewState.Idle);
      lfItemList = _model.result.items.first.itemStatus;
      lfAreaList = _model.result.items.first.area ;
      lfRoomList = _model.result.items.first.room ;
    }

    notifyListeners();
  }

  void createLostAndFound(BuildContext context, String selectedItemKey, String formattedDate, String selectedItemStatus,
      int selectedAreaNo, String owner, String ownerFolio, String selectedOwnerRoomKey, String ownerContactNo,
      String founder,
      String founderFolio, String founderRoomKey, String founderContactNo, String description, String instruction,
      String additionalInfo,String reference) async{
    showLoaderDialog(context);
    Map<String , dynamic> dataMap = {
      "lostFoundStatusKey": selectedItemKey,
    "reportedDate": formattedDate,
    "itemName": selectedItemStatus,
    "area": selectedAreaNo,
    "owner": owner,
    "ownerFolio": ownerFolio,
    "ownerRoomKey": selectedOwnerRoomKey,
    "ownerContactNo": ownerContactNo,
    "founder": founder,
    "founderFolio": founderFolio,
    "founderRoomKey": founderRoomKey,
    "founderContactNo": founderContactNo,
    "description": description,
    "instruction": instruction,
    "additionalInfo": additionalInfo,
    "staffKey": staffKey,
    "reference": reference
    };

    BaseResponse _res = await ApiService.createLostFound(context, dataMap);
    if(_res.success == true){
      Navigator.pop(context);
      showAlertDialog(context, "Success", "Record has been updated", (){
        Navigator.pop(context);
        Navigator.pop(context);
      });
      lostAndFoundItemList.clear();
      getLostFoundData(context);
    }else{
      showAlertDialog(context, "Error", "Please try again.",  (){
        Navigator.pop(context);
      });
    }
  }

  void getFloorMiniBar(BuildContext context) async{
    miniBarFloorList.clear();
    HotelFloorResponse _floor = await ApiService.getFloorMiniBar(context);
    miniBarFloorList.add(GetHotelFloor(floor: '0' , btnFloor: 'ALL'));
    miniBarFloorList.addAll(_floor.result.floorItems);
    notifyListeners();
  }

  void getRoomMiniBar(int floor , BuildContext context) async{
    setState(ViewState.Busy);
    miniBarRoomList.clear();
    RoomButtonModel _model = await ApiService.getRoomMiniBar(context , floor);
    if(_model.success){
      setState(ViewState.Idle);
      miniBarRoomList.addAll(_model.result.items);
    }

    notifyListeners();

  }

  void getRoomLaundry(int floor, BuildContext context)async {
    setState(ViewState.Busy);
    laundryRoomList.clear();
    RoomButtonModel _model = await ApiService.getRoomLaundry(context , floor);
    if(_model.success){
      setState(ViewState.Idle);
      laundryRoomList.addAll(_model.result.items);
    }

    notifyListeners();
  }

  void getHotelFloorLaundry(BuildContext context) async{
    laundryFloorList.clear();
    HotelFloorResponse _floor = await ApiService.getHotelFloorLaundry(context);
    laundryFloorList.add(GetHotelFloor(floor: '0' , btnFloor: 'ALL'));
    laundryFloorList.addAll(_floor.result.floorItems);
    notifyListeners();
  }

  void getRoomMiniBarCo(int floor, BuildContext context) async{
    setState(ViewState.Busy);
    miniBarCoRoomList.clear();
    RoomButtonModel _model = await ApiService.getRoomMiniBarCo(context , floor);
    if(_model.success){
      setState(ViewState.Idle);
      miniBarCoRoomList.addAll(_model.result.items);
    }

    notifyListeners();
  }

  void getFloorMiniBarCo(BuildContext context) async{
    miniBarCoFloorList.clear();
    HotelFloorResponse _floor = await ApiService.getFloorMiniBarCo(context);
    miniBarCoFloorList.add(GetHotelFloor(floor: '0' , btnFloor: 'ALL'));
    miniBarCoFloorList.addAll(_floor.result.floorItems);
    notifyListeners();
  }

  void getHistory(BuildContext context)async{
    setState(ViewState.Busy);
    HistoryModel _model = await ApiService.getHistroy(context);
    if(_model.success){
      setState(ViewState.Idle);
      historyList = _model.result.items;
    }

    notifyListeners();

  }

  void getViewLogs(BuildContext context) async{
    setState(ViewState.Busy);
    ViewLogResponse _model = await ApiService.getViewLog(context);
    if(_model.success){
      setState(ViewState.Idle);
      viewLogList.addAll(_model.result.items);
    }

    notifyListeners();
  }

  void getLaundryItem(BuildContext context , String roomNo) async {
    laundryItemModelList.clear();
    setState(ViewState.Busy);
    LaundryItemResponse _model = await ApiService.getLaundryItem(context , roomNo);
    if(_model.success == true){
      setState(ViewState.Idle);
      laundryItemModelList.addAll(_model.result.items);
    }

    notifyListeners();
  }

  void addLaundryItem(ItemSelected mLaundryItem , int index ){

  }

  void updateSelctedItem(ItemSelected selectedItem){
    for (var i = 0; i < tempItemSelectedList.length; i++) {
      if (tempItemSelectedList[i].itemKey == selectedItem.itemKey) {
        tempItemSelectedList[i].qty = selectedQty;
        break;
      }
    }
    notifyListeners();
  }

  void getInitialQty(ItemSelected mLaundryItem){
    for (var i = 0; i < tempItemSelectedList.length; i++) {
      if (tempItemSelectedList[i].itemKey == mLaundryItem.itemKey) {
        qty = tempItemSelectedList[i].qty == 0 ? 1 : tempItemSelectedList[i].qty;
        break;
      }
      qty = 1;
    }
   // qty = 1;
    notifyListeners();
  }

  void decrease() {
    if(qty > 1 ) qty--;
    notifyListeners();
  }

  void increase() {
     qty++;
    notifyListeners();
  }

  void decreaseSelectedItem() {
    if(selectedQty > 1 ) selectedQty--;
    notifyListeners();
  }

  void increaseSelectedItem() {
    selectedQty++;
    notifyListeners();
  }
  void addSelectedItemQty(int quantity) {
    selectedQty = quantity;
    notifyListeners();
  }

  void clearSelectedItem() {
    tempItemSelectedList.clear();
    qty = 1;
    selectedQty = 1;
    notifyListeners();
  }

  void postSelectedItems(BuildContext context ,String type ,  String roomNo, String roomKey, String reservationKey, String voucherNo) async{

    showLoaderDialog(context);
    tempItemSelectedList.removeWhere((element) => element.qty == 0);
    SelectedItemModel _item = SelectedItemModel(
        itemSelected: tempItemSelectedList,
         roomNo: roomNo,
     voucherNo: voucherNo == '' ? null : voucherNo,
     reservationKey: reservationKey,
     roomKey:roomKey
    );

    var json = selectedItemModelToJson(_item);
    BaseResponse _res = await ApiService.postSelectedItems(context,type , json);
    if(_res.success == true){
      //clearSelectedItem();
      if(type == 'LaundryRoom'){
        getLaundryItem(context, roomNo);
      }else if(type == 'MinibarRoom'){
        getMinibarItem(context, roomNo);
      }else{
        getMinibarCoItem(context, roomNo);
      }

      Navigator.pop(context);
      showAlertDialog(context, 'Success', "Selected items are posted.", (){
        Navigator.pop(context);
      });

    }else{
      Navigator.pop(context);
      showAlertDialog(context, 'Error', "Please try again later", (){
        Navigator.pop(context);
      });
    }
  }

  void getMinibarItem(BuildContext context, String roomNo) async{
    minibarItemList.clear();
    setState(ViewState.Busy);
    MinibarItemResponse _model = await ApiService.getMinibarItem(context , roomNo);
    if(_model.success){
      setState(ViewState.Idle);
      minibarItemList.addAll(_model.result.items);
    }else{
      setState(ViewState.Error);
      showAlertDialog(context, "Error", "This room is vacant. No action is required.", (){

      });
    }
    notifyListeners();
  }

  void getMinibarCoItem(BuildContext context, String roomNo) async{
    setState(ViewState.Busy);
    MinibarItemResponse _model = await ApiService.getMinibarCoItem(context , roomNo);
    if(_model.success == true){
      setState(ViewState.Idle);
      minibarCoItemList.addAll(_model.result.items);
    }else{
      setState(ViewState.Error);
      showAlertDialog(context, "Error", "This room is vacant. No action is required.", (){

      });
    }
    notifyListeners();
  }

  void addSelectedItem(MinibarItem minibarItem, int index) {
    var found = false;
    for (var i = 0; i < tempItemSelectedList.length; i++) {
      if (tempItemSelectedList[i].itemKey == minibarItem.itemKey) {
        tempItemSelectedList[i].qty += qty;
        found = true;
        break;
      }
    }
    if (!found) tempItemSelectedList.add(ItemSelected(
        itemKey: minibarItem.itemKey,
        description: minibarItem.description,
        qty: qty,
        salesPrice: minibarItem.salesPrice.toInt(),
        postCodeKey: minibarItem.postCodeKey

    ));
    notifyListeners();
  }


  void getLostFoundEditData(BuildContext context, String lostFoundKey) async{
    setState(ViewState.Busy);
    LostAndFoundEditResponse _lostFoundedit = await ApiService.getLostAndFoundEditData(context,  lostFoundKey);
    if(_lostFoundedit.success){
      setState(ViewState.Idle);
      lostFoundEditData = _lostFoundedit.result.lostFound;
    }
    notifyListeners();
  }

  void clickDnd(BuildContext context , String getRoomDndButton, String unit , String type) async{
    BaseResponse _baseResponse= await ApiService.setDND(context  ,getRoomDndButton , unit);
    if(_baseResponse.success == true){
      if(type == 'attend'){
        getAttendantList(context, currentFloorName, currentMaidStatus, currentGuestStatus, currentRoomStatus);
      }else if(type == 'super'){
        getSupervisorGrid(context, superVisorSelectedRoom, superFloor,superSelectedStaff);
      }else if(type == 'room'){
        getRoomList(context, roomPopupStatus,guestStatus, roomFloor);
      }else{
        getSupervisorModeGrid(context, superVisorSelectedRoom, superFloor,maidKey , superSelectedStaff , 1);
      }
        showAlertDialog(context, 'Success', "Record has been saved", (){
      //  Navigator.pop(context);
      });
    }else{
      showAlertDialog(context, 'Error', "Please try again", (){
      //  Navigator.pop(context);
      });
    }
    notifyListeners();
  }

  void clickStart(BuildContext context, String unit , String roomkey) async{
    showLoaderDialog(context);
    BaseResponse _base = await ApiService.clickStart(context , unit , roomkey);
    if(_base.success == true){
      getAttendantList(context, currentFloorName, currentMaidStatus, currentGuestStatus, currentRoomStatus);
      Navigator.pop(context);
      showAlertDialog(context, 'Success', "Record has been saved", (){
        getDashBoardData(context);
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      showAlertDialog(context, 'Error', "Please try again", (){
      });
    }

  }

  void getHistoryLogOfRoom(BuildContext context, String roomKey) async{
   // historyLogItemList.clear();
    setState(ViewState.Busy);
    HistoryLogOfRoom _history = await ApiService.getHistoryLogOfRoom(context , roomKey , staffKey);
    if(_history.success){
      setState(ViewState.Idle);
      historyLogItemList = _history.result.items;
    }else{

    }

    notifyListeners();
  }

  String attendantRoomKey ;
  void getCheckList(BuildContext context , String room)async{
    setState(ViewState.Busy);
    CheckLIstModel _check = await ApiService.getCheckList(context , room);
    if(_check.success){
      setState(ViewState.Idle);
      checkItemList = _check.result.items;
      attendantRoomKey = _check.result.items.first.roomKey;
    }else{
      setState(ViewState.Idle);
      showAlertDialog(context, "Error", "Something wrong", (){

      });
    }

    notifyListeners();
  }

  void decreaseItem(int index) {

    notifyListeners();
  }

  void clickPause(BuildContext context , String unit , String note , String roomKey) async{
    showLoaderDialog(context);
    BaseResponse _base = await ApiService.clickPause(context , unit , note , roomKey);
    if(_base.success == true){
      Navigator.pop(context);
      Navigator.pop(context);
      getAttendantList(context, currentFloorName, currentMaidStatus, currentGuestStatus, currentRoomStatus);
      showAlertDialog(context, 'Success', "Record has been saved", (){
        getDashBoardData(context);
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      Navigator.pop(context);
      showAlertDialog(context, 'Error', "Please try again", (){
        Navigator.pop(context);
      });
    }
  }

  void clickEnd(BuildContext context, String unit , String roomKey) async{
    showLoaderDialog(context);
    BaseResponseToken _base = await ApiService.clickEnd(context , unit , roomKey);
    if(_base.success == true){
      Navigator.pop(context);
      Navigator.pop(context);
      await ApiService.sendNotification(context, "End", _base.result.first.message, _base.result.first.to);
      getAttendantList(context, currentFloorName, currentMaidStatus, currentGuestStatus, currentRoomStatus);
      showAlertDialog(context, 'Success', "Record has been saved", (){
        getDashBoardData(context);
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      Navigator.pop(context);
      showAlertDialog(context, 'Error', "Please try again", (){
        Navigator.pop(context);
      });
    }
  }

  void getRoomData(BuildContext context) async{
    floorList.clear();
    roomList.clear();
    maidStatusList.clear();
    guestStatusList.clear();
    setState(ViewState.Busy);
    RoomStatusResponse _roomResponse = await ApiService.getRoomData(context);
    if(_roomResponse.success == true){
      setState(ViewState.Idle);
      floorList.add(GetHotelFloor(floor: '0' , btnFloor: 'ALL'));
      roomList.add(GetRoomStatuss(roomStatusKey : "",
          roomStatus: "ALL"));
      guestStatusList.add(GetGuestStatuss(guestStatusKey: '' ,
          statusCode: 0 , status: 'ALL'));
      floorList.addAll(_roomResponse.result.items.first.getHotelFloors);
      roomList.addAll(_roomResponse.result.items.first.getRoomStatuss);
      guestStatusList.addAll(_roomResponse.result.items.first.getGuestStatuss);

    }

    notifyListeners();

  }

  void getRoomList(BuildContext context, String roomStatus, String mguestStatus ,  String floor) async {
    setState(ViewState.Busy);
    roomGridList.clear();
    roomPopupStatus = roomStatus;
    guestStatus = mguestStatus;

    roomFloor = floor;
    RoomGridResponse _room = await ApiService.getRoomGrid(context , roomStatus ,guestStatus , floor);
    if(_room.success){
      setState(ViewState.Idle);
      roomGridList.addAll(_room.result.items);
    }
   notifyListeners();
  }

  void getRoomPopup(BuildContext context, roomNo) async{
    roomPopUpItemList.clear();
    RoomPopUpResponse _popup = await ApiService.getRoomPopUpData(context , roomNo);
    mRoomPopupItem = _popup.result.items.first;
    roomPopUpItemList = _popup.result.items.first.attendantlist;
    notifyListeners();

  }

  void addAssign(BuildContext context, String previousAttendantKey, String maidKey, String name,
      String roomNo , String previousName)async {
    Map<String , dynamic> data = {
      "previousAttendantKey": previousAttendantKey,
      "strAssignedAttendantKey": maidKey,
      "strAssignedAttendantName": name,
      "roomNo": roomNo,
      "previousAttendantName": previousName
    };

    BaseResponseToken _base = await ApiService.addAssign(context, data);
    if(_base.success){
      for (final noti in _base.result){
        if(noti.message.contains('is assigned to')){
          await ApiService.sendNotification(context, "Attendant Assignment", noti.message, noti.to);
        }else if(noti.message.contains('is unassigned from')){
          await ApiService.sendNotification(context, "Attendant Unassignment", noti.message, noti.to);
        }else if(noti.message.contains("is reassigned from")){
          await ApiService.sendNotification(context, "Attendant Reassignment", noti.message, noti.to);
        }
        

      }
      getRoomList(context, roomPopupStatus, guestStatus,roomFloor);
      showAlertDialog(context, "Success", "Record have been saved", ()async{


      });
    }else{
      showAlertDialog(context, "Fail", "Please try again", (){

      });
    }
  }

  void clickUnassign(BuildContext context, String previousAttendantKey, String roomNo , String name) async{
    Map<String , dynamic> data = {
      "previousAttendantKey": previousAttendantKey,
      "roomNo": roomNo,
      "previousAttendantName": name
    };

    BaseResponseToken _base = await ApiService.clickUnassign(context, data);
    if(_base.success){
      Navigator.pop(context);

      for (final noti in _base.result){
        if(noti.message.contains('is assigned to')){
          await ApiService.sendNotification(context, "Attendant Assignment", noti.message, noti.to);
        }else if(noti.message.contains('is unassigned from')){
          await ApiService.sendNotification(context, "Attendant Unassignment", noti.message, noti.to);
        }else if(noti.message.contains("is reassigned from")){
          await ApiService.sendNotification(context, "Attendant Reassignment", noti.message, noti.to);
        }


      }
       getRoomList(context, roomPopupStatus,guestStatus, roomFloor);
      showAlertDialog(context, "Success", "Record have been saved", (){
        getDashBoardData(context);
      });
    }else{
      showAlertDialog(context, "Fail", "Please try again", (){

      });
    }

  }

  void getSupervisorData(BuildContext context) async{
    setState(ViewState.Busy);
    superVisorFloorList.clear();
    superVisorRoomList.clear();

    SupervisorStatusResponse _res = await ApiService.getSupervisroData(context);
    if(_res.success == true){
      setState(ViewState.Idle);
      superVisorFloorList.add(GetHotelFloor(floor: '0' , btnFloor: 'ALL'));
      superVisorRoomList.add(GetRoomStatuss(roomStatusKey : "",
          roomStatus: "ALL"));
      superVisorFloorList.addAll(_res.result.items.first.getHotelFloors);
      superVisorRoomList.addAll(_res.result.items.first.getRoomStatuss);
      staffList = _res.result.items.first.staffList;

    }

    notifyListeners();

  }

  List<SuperVisorItem> supervisorItemList =[];
  String superVisorSelectedRoom ;
  String superFloor;
  String superSelectedStaff;
  void getSupervisorGrid(BuildContext context, String selectedRoom, String floor , String selectedStaff)async {
    setState(ViewState.Busy);
    superVisorSelectedRoom = selectedRoom;
    superFloor = floor;
    superSelectedStaff = selectedStaff;
    SupervisorGridResponse _res = await ApiService.getSupervisorGrid(context, selectedRoom , floor , selectedStaff);
    if(_res.success){
      setState(ViewState.Idle);
      supervisorItemList = _res.result.items;
    }
  notifyListeners();
  }

  List<HistoryLogOfRoomItem> supervisorHistoryList = [];
  void getHistorySupervisor(BuildContext context, String roomKey , int pageSize) async{
    setState(ViewState.Busy);
    HistoryLogOfRoom _res = await ApiService.getSupervisorHistory(context, roomKey , pageSize);
    if(_res.success){
      setState(ViewState.Idle);
      supervisorHistoryList = _res.result.items;
    }
    notifyListeners();

  }

  void confirmClean(BuildContext context, String room, String text , String phy , String roomKey)async {
    showLoaderDialog(context);
    BaseResponseToken _base = await ApiService.confirmClean(context , room, text , phy , roomKey);
    if(_base.success){
      Navigator.pop(context);
      Navigator.pop(context);
      await ApiService.sendNotification(context, "Clean", _base.result.first.message, _base.result.first.to);
      getSupervisorGrid(context, superVisorSelectedRoom, superFloor,superSelectedStaff);
      showAlertDialog(context, "Success", "Record have been saved", (){
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      showAlertDialog(context, "Fail", "Please try again", (){
      });
    }
  }

  void confirmDirty(BuildContext context, String room, String text, String phy ,String roomKey) async {
    showLoaderDialog(context);
    BaseResponseToken _base = await ApiService.confirmDirty(context , room, text , phy , roomKey);
    if(_base.success){
      Navigator.pop(context);
      Navigator.pop(context);
      await ApiService.sendNotification(context, "Dirty", _base.result.first.message, _base.result.first.to);
      getSupervisorGrid(context, superVisorSelectedRoom, superFloor,superSelectedStaff);
      showAlertDialog(context, "Success", "Record have been saved", (){
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      showAlertDialog(context, "Fail", "Please try again", (){

      });
    }
  }

  List<SupCheckList> supCheckItemList = [];
  String supRoomKey ;
  void getSupervisorCheckList(BuildContext context, String unit) async{
    setState(ViewState.Busy);
    SupervisorCheckListResponse _res = await ApiService.getSupCheckList(context , unit);
    if(_res.success){
      setState(ViewState.Idle);
      supRoomKey = _res.result.items.first.roomKey;
      supCheckItemList = _res.result.items.first.supCheckList;

    }
    notifyListeners();
  }

  void updateCheckbox(bool value , int index) {
    if(value){
      supCheckItemList[index].checked = 1;
    }else{
      supCheckItemList[index].checked = 0;
    }
    notifyListeners();
  }

  void saveCheckList(BuildContext context) async{
    showLoaderDialog(context);

    SupCheckItem data = SupCheckItem(
      supCheckList: supCheckItemList,
      roomKey: supRoomKey
    );

    String json = subCheckItemToJson(data);
    BaseResponse _res = await ApiService.saveCheckList(context , json );
    if(_res.success){
      Navigator.pop(context);
      showAlertDialog(context, "Success", "Record have been saved", (){
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      showAlertDialog(context, "Error", "Please try again", (){
        Navigator.pop(context);
      });
    }
  }

  void increaseCheckList(int index) {
    checkItemList.first.attendantCheckList[index].quantity++;
    notifyListeners();
  }

  void decreaseCheckList(int index) {
    if(checkItemList.first.attendantCheckList[index].quantity > 0 ){
      checkItemList.first.attendantCheckList[index].quantity--;
    }

    notifyListeners();
  }


  void updateRoomCheckList(BuildContext context) async{
    CheckListItem data = CheckListItem(
        attendantCheckList : checkItemList.first.attendantCheckList,
      roomKey: attendantRoomKey,
    );
    String json = checkListItemToJson(data);
    BaseResponse _res = await ApiService.updateAttendantCheckList(context , json);
    if(_res.success){
      Navigator.pop(context);
      showAlertDialog(context, "Success", "Record have been saved", (){
      });
    }else {
      Navigator.pop(context);
      showAlertDialog(context, "Error", "Please try again", () {

      });
    }
  }

  void deleteSelectedItem(ItemSelected selectedItem) {
    for (var i = 0; i < tempItemSelectedList.length; i++) {
      if (tempItemSelectedList[i].itemKey == selectedItem.itemKey) {
        tempItemSelectedList.removeAt(i) ;
        break;
      }
    }
    qty = 1;
    selectedQty = 1;
    notifyListeners();
  }

  void requestPermission() async{
    FirebaseMessaging messaging= FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted permission');
    }else  if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted provisional permission');
    }else{
      print('User declined or has not accepted suth');
    }

  }

  void getSupervisorModData(BuildContext context) async{
    setState(ViewState.Busy);
    superVisorFloorList.clear();
    superVisorRoomList.clear();
    maidStatusCountList.clear();
    staffList.clear();

    SupervisorModeData _res = await ApiService.getSupervisorModData(context);
    if(_res.success == true){
      setState(ViewState.Idle);
      superVisorFloorList.add(GetHotelFloor(floor: '0' , btnFloor: 'ALL'));
      superVisorRoomList.add(GetRoomStatuss(roomStatusKey : "",
          roomStatus: "ALL"));
      staffList.add(StaffList(maidKey: '' , name: 'ALL'));
      superVisorFloorList.addAll(_res.result.items.first.getHotelFloors);
      superVisorRoomList.addAll(_res.result.items.first.getRoomStatuss);
      staffList.addAll(_res.result.items.first.staffList);
      maidStatusCountList.addAll(_res.result.items.first.maidStatusCount);

    }

    notifyListeners();
  }

  List<SupervisorModeList> supervisorModeList = [];
  String maidKey ;
  void getSupervisorModeGrid(BuildContext context, String selectedRoom, String floor ,String maidKey, String selectedMaidStatus , int currentPage)async {
    setState(ViewState.Busy);
    if(currentPage == 1){
      supervisorModeList.clear();
    }
    superVisorSelectedRoom = selectedRoom;
    superFloor = floor;
    superSelectedStaff = selectedMaidStatus;
    this.maidKey = maidKey;
    SupervisorModeGridData _res = await ApiService.getSupervisorModeGrid(context, selectedRoom , floor ,maidKey, selectedMaidStatus , currentPage);
    if(_res.success){
      setState(ViewState.Idle);
      totalCount = _res.result.totalCount;
      supervisorModeList.addAll(_res.result.items.first.supervisorModeList);
    }
    notifyListeners();
  }

  void confirmCleanMode(BuildContext context, String room, String text , String phy , String roomKey)async {
    showLoaderDialog(context);
    BaseResponseToken _base = await ApiService.confirmCleanMode(context , room, text , phy , roomKey);
    if(_base.success){
      Navigator.pop(context);
      Navigator.pop(context);
      for(var mes in _base.result){
        await ApiService.sendNotification(context, "Clean", mes.message, mes.to);
      }
      getSupervisorModeGrid(context, superVisorSelectedRoom, superFloor,maidKey , superSelectedStaff , 1);
      showAlertDialog(context, "Success", "Record have been saved", (){
        //Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      showAlertDialog(context, "Fail", "Please try again", (){
      });
    }
  }

  void confirmDirtyMode(BuildContext context, String room, String text , String phy , String roomKey)async {
    showLoaderDialog(context);
    BaseResponseToken _base = await ApiService.confirmDirtyMode(context , room, text , phy , roomKey);
    if(_base.success){
      Navigator.pop(context);
     // Navigator.pop(context);
      for(var mes in _base.result){
        await ApiService.sendNotification(context, "Dirty", mes.message, mes.to);
      }
      getSupervisorModeGrid(context, superVisorSelectedRoom, superFloor,maidKey , superSelectedStaff , 1);
      showAlertDialog(context, "Success", "Record have been saved", (){
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      showAlertDialog(context, "Fail", "Please try again", (){
      });
    }
  }

  void updateLaundryItem(List<LaundryItem> laundryItems) {
    tempItemSelectedList.clear();
    for(var item in laundryItems){
      tempItemSelectedList.add(ItemSelected(
          itemKey: item.itemKey,
          description: item.description,
          qty: 0,
          salesPrice: item.salesPrice.toInt(),
          postCodeKey: item.postCodeKey

      ));
    }
    notifyListeners();
  }

  void updateMinibarItem(List<MinibarItem> minibarItems) {
    tempItemSelectedList.clear();
    for(var item in minibarItems){
      tempItemSelectedList.add(ItemSelected(
          itemKey: item.itemKey,
          description: item.description,
          qty: 0,
          salesPrice: item.salesPrice.toInt(),
          postCodeKey: item.postCodeKey

      ));
    }
    notifyListeners();
  }

  void updateItemQty(ItemSelected mLaundryItem, int index, String s) {
    if(s == 'increase'){
      for (var i = 0; i < tempItemSelectedList.length; i++) {
        if (tempItemSelectedList[i].itemKey == mLaundryItem.itemKey) {
          tempItemSelectedList[i].qty += 1;
          break;
        }
      }
    }else{
      for (var i = 0; i < tempItemSelectedList.length; i++) {
        if (tempItemSelectedList[i].itemKey == mLaundryItem.itemKey) {
          if(tempItemSelectedList[i].qty > 0){
            tempItemSelectedList[i].qty -= 1;
          }

          break;
        }
      }
    }


    notifyListeners();
  }

}
