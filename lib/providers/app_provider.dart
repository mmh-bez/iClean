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
import 'package:i_clean/models/view_logs_response.dart';
import 'package:i_clean/models/woentry/wo_entry_model.dart';
import 'package:i_clean/models/task_model.dart';
import 'package:i_clean/providers/base_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:i_clean/service/api_service.dart';
import 'package:i_clean/ui/dash_board.dart';

import '../models/floor_model.dart';
import '../utils/const.dart';

class AppProvider extends BaseProvider{
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
  var selectedQty = 0;

  List<RoomPopUpItemList> roomPopUpItemList = [];
  RoomPopUpItem mRoomPopupItem;

  String roomPopupStatus;
  String roomFloor;

  void login(BuildContext context , String pin) async{
    showLoaderDialog(context);
    LoginModel loginModel = await ApiService.login(context , pin);
    if(loginModel.result != null && loginModel.success == true){
      Navigator.pop(context);
      token = loginModel.result.accessToken;
      staffKey = loginModel.result.staffKey;
      name = loginModel.result.name;
      isAdmin = loginModel.result.isAdmin;
      Navigator.pushNamedAndRemoveUntil(context, DashBoard.routeName, (Route<dynamic> route) => false);
    }else{
     showAlertDialog(context, "Wrong", "Invalid user name or password", (){
       Navigator.pop(context);
     });
    }
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
    if(_attendantDataModel.success == true){
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

      reportedByList.addAll(_woEntry.result.items.first.getReportedBy);
      lostFoundRoomList.addAll(_woEntry.result.items.first.room);
      areaList.addAll(_woEntry.result.items.first.area);
      workTypeList.addAll(_woEntry.result.items.first.workType);
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
        Navigator.pop(context);
      });
    }else{
      showAlertDialog(context, "Error", "Your order is not success.Please try again.",  (){
        Navigator.pop(context);
      });
    }
  }

  void getLostFoundData(BuildContext context) async{

    LostAndFoundData _lostFound = await ApiService.getLostAndFoundData(context);
    if(_lostFound.success == true){

      lostAndFoundItemList.addAll(_lostFound.result.items);
    }

    notifyListeners();
  }

  void getLostFoundDataModel(BuildContext context)async{
    LostAndFoundDataModel _model = await ApiService.getLostAndFoundDataModel(context);
    if(_model.success == true) {

      lfItemList.addAll(_model.result.items.first.itemStatus);
      lfAreaList.addAll(_model.result.items.first.area);
      lfRoomList.addAll(_model.result.items.first.room);
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
    historyList.clear();
    HistoryModel _model = await ApiService.getHistroy(context);
    historyList.addAll(_model.result.items);
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
    setState(ViewState.Busy);
    LaundryItemResponse _model = await ApiService.getLaundryItem(context , roomNo);
    if(_model.success == true){
      setState(ViewState.Idle);
      laundryItemModelList.addAll(_model.result.items);
    }

    notifyListeners();
  }

  void addLaundryItem(LaundryItem mLaundryItem , int index ){
    var found = false;
    for (var i = 0; i < tempItemSelectedList.length; i++) {
      if (tempItemSelectedList[i].itemKey == mLaundryItem.itemKey) {
        tempItemSelectedList[i].qty += qty;
        found = true;
        break;
      }
    }
    if (!found) tempItemSelectedList.add(ItemSelected(
      no: index,
      itemKey: mLaundryItem.itemKey,
      description: mLaundryItem.description,
      qty: qty,
      salesPrice: mLaundryItem.salesPrice.toInt(),
      postCodeKey: mLaundryItem.postCodeKey

    ));
    notifyListeners();
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
        qty = tempItemSelectedList[i].qty;
        break;
      }
      qty = 0;
    }
    notifyListeners();
  }

  void decrease() {
    if(qty > 0 ) qty--;
    notifyListeners();
  }

  void increase() {
     qty++;
    notifyListeners();
  }

  void decreaseSelectedItem() {
    if(selectedQty > 0 ) selectedQty--;
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
    notifyListeners();
  }

  void postSelectedItems(BuildContext context ,String type ,  String roomNo, String roomKey, String reservationKey, String voucherNo) async{

    showLoaderDialog(context);
    SelectedItemModel _item = SelectedItemModel(

      itemSelected: tempItemSelectedList,
         roomNo: roomNo,
     voucherNo: voucherNo,
     reservationKey: reservationKey,
     roomKey:roomKey
    );

    var json = selectedItemModelToJson(_item);
    BaseResponse _res = await ApiService.postSelectedItems(context,type , json);
    if(_res.success == true){
      clearSelectedItem();
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
    setState(ViewState.Busy);
    MinibarItemResponse _model = await ApiService.getMinibarItem(context , roomNo);
    if(_model.success == true){
      setState(ViewState.Idle);
      minibarItemList.addAll(_model.result.items);
    }
    notifyListeners();
  }

  void getMinibarCoItem(BuildContext context, String roomNo) async{
    setState(ViewState.Busy);
    MinibarItemResponse _model = await ApiService.getMinibarCoItem(context , roomNo);
    if(_model.success == true){
      setState(ViewState.Idle);
      minibarCoItemList.addAll(_model.result.items);
    }
    notifyListeners();
  }

  void addMinibarItem(MinibarItem minibarItem, int index) {
    var found = false;
    for (var i = 0; i < tempItemSelectedList.length; i++) {
      if (tempItemSelectedList[i].itemKey == minibarItem.itemKey) {
        tempItemSelectedList[i].qty += qty;
        found = true;
        break;
      }
    }
    if (!found) tempItemSelectedList.add(ItemSelected(
        no: index,
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

  void clickDnd(BuildContext context , String getRoomDndButton, String unit) async{
    BaseResponse _baseResponse= await ApiService.setDND(context  ,getRoomDndButton , unit);
    if(_baseResponse.success == true){
      getAttendantList(context, currentFloorName, currentMaidStatus, currentGuestStatus, currentRoomStatus);
      showAlertDialog(context, 'Success', "Record has been saved", (){
        Navigator.pop(context);
      });
    }else{
      showAlertDialog(context, 'Error', "Please try again", (){
        Navigator.pop(context);
      });
    }
    notifyListeners();
  }

  void clickStart(BuildContext context, String unit) async{
    showLoaderDialog(context);
    BaseResponse _base = await ApiService.clickStart(context , unit);
    if(_base.success == true){
      getAttendantList(context, currentFloorName, currentMaidStatus, currentGuestStatus, currentRoomStatus);
      Navigator.pop(context);
      showAlertDialog(context, 'Success', "Record has been saved", (){
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      showAlertDialog(context, 'Error', "Please try again", (){
        Navigator.pop(context);
      });
    }

  }

  void getHistoryLogOfRoom(BuildContext context, String roomKey) async{
   // historyLogItemList.clear();
    HistoryLogOfRoom _history = await ApiService.getHistoryLogOfRoom(context , roomKey , staffKey);
    historyLogItemList = _history.result.items;
    notifyListeners();
  }

  void getCheckList(BuildContext context , String room)async{
    CheckLIstModel _check = await ApiService.getCheckList(context , room);
    checkItemList = _check.result.items;
    notifyListeners();
  }

  void decreaseItem(int index) {

    notifyListeners();
  }

  void clickPause(BuildContext context , String unit) async{
    showLoaderDialog(context);
    BaseResponse _base = await ApiService.clickPause(context , unit);
    if(_base.success == true){
      Navigator.pop(context);
      getAttendantList(context, currentFloorName, currentMaidStatus, currentGuestStatus, currentRoomStatus);
      showAlertDialog(context, 'Success', "Record has been saved", (){
        Navigator.pop(context);
      });
    }else{
      Navigator.pop(context);
      showAlertDialog(context, 'Error', "Please try again", (){
        Navigator.pop(context);
      });
    }
  }

  void clickEnd(BuildContext context, String unit) async{
    showLoaderDialog(context);
    BaseResponse _base = await ApiService.clickEnd(context , unit);
    if(_base.success == true){
      Navigator.pop(context);
      getAttendantList(context, currentFloorName, currentMaidStatus, currentGuestStatus, currentRoomStatus);
      showAlertDialog(context, 'Success', "Record has been saved", (){
        Navigator.pop(context);
      });
    }else{
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

  void getRoomList(BuildContext context, String roomStatus, String floor) async {
    setState(ViewState.Busy);
    roomGridList.clear();
    roomPopupStatus = roomStatus;
    roomFloor = floor;
    RoomGridResponse _room = await ApiService.getRoomGrid(context , roomStatus , floor);
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
      String roomNo)async {
    Map<String , dynamic> data = {
      "previousAttendantKey": previousAttendantKey,
      "strAssignedAttendantKey": maidKey,
      "strAssignedAttendantName": name,
      "roomNo": roomNo
    };

    BaseResponse _base = await ApiService.addAssign(context, data);
    if(_base.success){
      getRoomList(context, roomPopupStatus, roomFloor);
      showAlertDialog(context, "Success", "Record have been saved", (){

      });
    }else{
      showAlertDialog(context, "Fail", "Please try again", (){

      });
    }
  }

  void clickUnassign(BuildContext context, String previousAttendantKey, String roomNo) async{
    Map<String , dynamic> data = {
      "previousAttendantKey": previousAttendantKey,
      "roomNo": roomNo
    };

    BaseResponse _base = await ApiService.clickUnassign(context, data);
    if(_base.success){
      Navigator.pop(context);
      getRoomList(context, roomPopupStatus, roomFloor);
      showAlertDialog(context, "Success", "Record have been saved", (){

      });
    }else{
      showAlertDialog(context, "Fail", "Please try again", (){

      });
    }

  }

}
