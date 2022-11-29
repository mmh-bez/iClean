import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:i_clean/models/attendant/attendant_data_model.dart';
import 'package:i_clean/models/attendant/attendant_model.dart';
import 'package:i_clean/models/attendant/check_list_model.dart';
import 'package:i_clean/models/attendant/history_log_of_room.dart';
import 'package:i_clean/models/base_response_token.dart';
import 'package:i_clean/models/floor_model.dart';
import 'package:i_clean/models/history_model.dart';
import 'package:i_clean/models/laundry/laundry_item_response.dart';
import 'package:i_clean/models/login_model.dart';
import 'package:i_clean/models/lost_found/LostAndFoundDataModel.dart';
import 'package:i_clean/models/lost_found/lost_and_found_edit_response.dart';
import 'package:i_clean/models/lost_found/lost_found_model.dart';
import 'package:i_clean/models/base_response.dart';
import 'package:i_clean/models/minibar/minibar_item_response.dart';
import 'package:i_clean/models/room/room_grid_response.dart';
import 'package:i_clean/models/room/room_popup_response.dart';
import 'package:i_clean/models/room/room_status_response.dart';
import 'package:i_clean/models/room_button.dart';
import 'package:i_clean/models/supervisor/super_visor_checklist_response.dart';
import 'package:i_clean/models/supervisor/super_visor_grid_response.dart';
import 'package:i_clean/models/supervisor/super_visor_status_response.dart';
import 'package:i_clean/models/view_logs_response.dart';
import 'package:i_clean/models/woentry/wo_entry_model.dart';
import 'package:i_clean/models/task_model.dart';
import 'package:i_clean/service/api_util.dart';
import 'package:i_clean/utils/const.dart';

class ApiService{
  static Response response;

  static Future<LoginModel> login(BuildContext context , String pin)async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.post('/TokenAuth/AuthenticatePINMobile' , data: {
      "userNameOrEmailAddress": pin,
      "password": "string",
      "twoFactorVerificationCode": "string",
      "rememberClient": true,
      "twoFactorRememberClientToken": "string",
      "singleSignIn": true,
      "returnUrl": "string",
      "captchaResponse": "string",
      "tenantName": "Chancellor"
    });

    return loginModelFromJson(response.data);
  }

  static Future<AttendantModel> getAttendantList(BuildContext context, String floorName, String maidStatus, String guestStatus, String roomStatus)async {
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/MyTask/GetBindGrid?'
        'MaidStatus=$maidStatus&RoomStatus=$roomStatus&GuestStatus=$guestStatus&FloorNo=$floorName');

    return attendantModelFromJson(response.data);

  }

  static Future<TaskModel> getTask(BuildContext context) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/MaidStatus/GetDashboardViewData');

    return dashboardModelFromJson(response.data);
  }

  static Future<AttendantDataModel> getAttendantData(BuildContext context) async {
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/MyTask/GetMyTaskViewData');

    return attendantDataModelFromJson(response.data);
  }

  static Future<WoEntryDataModel> getWoEntryData(BuildContext context) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/WorkOrderEntry/GetWorkOrderEntryViewData');

    return woEntryDataModelFromJson(response.data);
  }

  static Future<BaseResponse> addWorkOrder(BuildContext context, Map<String, dynamic> dataMap) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/WorkOrderEntry/AddWorkOrderEntory' ,
    data: jsonEncode(dataMap));

    return baseResponseFromJson(response.data);
  }

  static Future<LostAndFoundData> getLostAndFoundData(BuildContext context) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/LostFound/GetAllLostFound' );

    return lostAndFoundDataFromJson(response.data);
  }

  static Future<LostAndFoundDataModel> getLostAndFoundDataModel(BuildContext context) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/LostFound/GetLostFoundViewData' );

    return lostAndFoundDataModelFromJson(response.data);
  }

  static Future<BaseResponse> createLostFound(BuildContext context, Map<String, dynamic> dataMap) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/LostFound/CreateOrUpdateLostFound' ,
        data: jsonEncode(dataMap));

    return baseResponseFromJson(response.data);
  }

  static Future<HotelFloorResponse> getFloorMiniBar(BuildContext context) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/MinibarRoom/GetBindHotelFloorList' );
    return hotelFloorResponseFromJson(response.data);
  }

  static Future<RoomButtonModel> getRoomMiniBar(BuildContext context, int floor) async{

    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/MinibarRoom/GetBindHotelRoomButtonList?floorNo=$floor' );
    return roomButtonModelFromJson(response.data);
  }

  static  Future<RoomButtonModel> getRoomLaundry(BuildContext context, int floor) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/LaundryRoom/GetBindHotelRoomButtonList?floorNo=$floor' );
    return roomButtonModelFromJson(response.data);
  }

  static getHotelFloorLaundry(BuildContext context)async {
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/LaundryRoom/GetBindHotelFloorList' );
    return hotelFloorResponseFromJson(response.data);
  }

  static  Future<RoomButtonModel> getRoomMiniBarCo(BuildContext context, int floor) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/MiniBarCORoom/GetBindHotelRoomButtonList?floorNo=$floor' );
    return roomButtonModelFromJson(response.data);
  }

  static getFloorMiniBarCo(BuildContext context) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/MiniBarCORoom/GetBindHotelFloorList' );
    return hotelFloorResponseFromJson(response.data);
  }

  static Future<HistoryModel> getHistroy(BuildContext context) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/History/GetTodayHistory?staffKey=$staffKey' );
    return historyModelFromJson(response.data);

  }

  static Future<ViewLogResponse> getViewLog(BuildContext context) async {
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/ViewLogs/GetBindGrid' );
    return viewLogResponseFromJson(response.data);
  }

  static Future<LaundryItemResponse> getLaundryItem(BuildContext context, String roomNo) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/LaundryRoom/GetLaundryItemViewData?roomNo=$roomNo' );
    return laundryItemResponseFromJson(response.data);
  }

  static Future<BaseResponse> postSelectedItems(context,String type, String dataMap) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/$type/btnAddItemClick' , data: dataMap );
    return baseResponseFromJson(response.data);
  }

  static Future<MinibarItemResponse> getMinibarItem(BuildContext context, String roomNo)async {
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/MinibarRoom/GetMinibarItemViewData?roomNo=$roomNo' );
    return minibarItemResponseFromJson(response.data);
  }

  static Future<MinibarItemResponse> getMinibarCoItem(BuildContext context, String roomNo) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/MinibarRoom/GetMinibarItemViewData?roomNo=$roomNo' );
    return minibarItemResponseFromJson(response.data);
  }

  static Future<LostAndFoundEditResponse> getLostAndFoundEditData(BuildContext context, String lostFoundKey) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/LostFound/GetLostFoundForEdit?Id=$lostFoundKey' );
    return lostAndFoundEditResponseFromJson(response.data);
  }

  static Future<BaseResponse> setDND(BuildContext context ,String getRoomDndButton, String unit) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/RoomStatusPage/btnUpdateDND?strMode=$getRoomDndButton&strRoomNo=$unit' );
    return baseResponseFromJson(response.data);

  }

  static Future<BaseResponse> clickStart(BuildContext context, String room , String roomkey) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/PopupUpdateMaidStatus/StartSave', data: {
    "strMode": "s",
    "strRoomNo": room,
    "roomKey": roomkey
    });
    return baseResponseFromJson(response.data);
  }

  static Future<HistoryLogOfRoom> getHistoryLogOfRoom(BuildContext context, String roomKey, String staffKey) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/MyTask/GetShowLog?'
        'roomkey=$roomKey&staffkey=$staffKey' );
    return historyLogOfRoomFromJson(response.data);
  }

  static Future<CheckLIstModel> getCheckList(BuildContext context, String room) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/MyTask/GetCheckList?strRoomNo=$room' );
    return checkLIstModelFromJson(response.data);
  }

  static Future<BaseResponse> clickPause(BuildContext context, String unit , String note , String roomKey) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/PopupUpdateMaidStatus/DelaySave' , data: {
      "strMode": "delay",
      "strRoomNo": unit,
      "note": note,
      "roomKey": roomKey
    });
    return baseResponseFromJson(response.data);

  }

  static Future<BaseResponseToken> clickEnd(BuildContext context, String unit , String roomKey) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/PopupUpdateMaidStatus/EndSave' , data:
    {
      "strMode": "e",
      "strRoomNo": unit,
      "roomKey": roomKey
    });
    return baseResponseTokenFromJson(response.data);
  }

  static Future<RoomStatusResponse> getRoomData(BuildContext context) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/RoomStatusPage/GetRoomViewData' );
    return roomStatusResponseFromJson(response.data);
  }

  static Future<RoomGridResponse> getRoomGrid(BuildContext context, String roomStatus, String guestStatus , String floor) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/RoomStatusPage/GetBindGrid?SelectedRoomStatus=$roomStatus&GuestStatus=$guestStatus&floorNo=$floor' );
    return roomGridResponseFromJson(response.data);
  }

  static Future<RoomPopUpResponse> getRoomPopUpData(BuildContext context, roomNo) async{
    var _api = await ApiUtil.connectNoAuth(context);
    response = await _api.get('/services/app/RoomStatusPage/GetRoomPopupViewData?roomNo=$roomNo' );
    return roomPopUpResponseFromJson(response.data);
  }

  static Future<BaseResponseToken> addAssign(BuildContext context, Map<String, dynamic> data) async {
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/RoomStatusPage/btnAssignClick' ,
    data: data
    );
    return baseResponseTokenFromJson(response.data);
  }

  static Future<BaseResponseToken> clickUnassign(BuildContext context, Map<String, dynamic> data) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/RoomStatusPage/lbtnUnassignClick' ,
        data: data
    );
    return baseResponseTokenFromJson(response.data);
  }

  static Future<SupervisorStatusResponse> getSupervisroData(BuildContext context) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/RoomsToInspect/GetRoomToInspectViewData'
    );
    return supervisorStatusResponseFromJson(response.data);
  }

  static Future<SupervisorGridResponse> getSupervisorGrid(BuildContext context , String selectedRoom, String floor , String selectedStaff) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/RoomsToInspect/GetBindGrid?SelectedRoomStatus=$selectedRoom&FloorNo=$floor&MaidKey=$selectedStaff'
    );
    return supervisorGridResponseFromJson(response.data);
  }

  static Future<HistoryLogOfRoom> getSupervisorHistory(BuildContext context , String roomKey)async {
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/MyTask/GetShowLog?roomkey=$roomKey');
    return historyLogOfRoomFromJson(response.data);

  }

  static Future<BaseResponseToken> confirmClean(BuildContext context, String room, String text , String phy , String roomKey) async {
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/PopupUpdateMaidStatus/CleanSave' , data: {
      "strMode": "c",
      "strRoomNo": room,
      "note": text,
      "phy": phy,
      "roomKey": roomKey
    });
    return baseResponseTokenFromJson(response.data);
  }

  static Future<BaseResponseToken> confirmDirty(BuildContext context, String room, String text, String phy , String roomKey) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/PopupUpdateMaidStatus/DirtySave' , data: {
      "strMode": "d",
      "strRoomNo": room,
      "note": text,
      "phy": phy,
      "roomKey": roomKey
    });
    return baseResponseTokenFromJson(response.data);
  }

  static Future<SupervisorCheckListResponse> getSupCheckList(BuildContext context, String unit) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.get('/services/app/RoomsToInspect/GetSupCheckList?strRoomNo=$unit');
    return supervisorCheckListResponseFromJson(response.data);
  }

  static Future<BaseResponse> saveCheckList(BuildContext context, var data) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/RoomsToInspect/SupCheckListSave' , data: data);
    return baseResponseFromJson(response.data);

  }

  static Future<BaseResponse> updateAttendantCheckList(BuildContext context , String json) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/MyTask/CheckListSave' , data: json);
    return baseResponseFromJson(response.data);
  }

  static void addFirebaseToken(BuildContext context , String token) async{
    var _api = await ApiUtil.connectWithAuth(context);
    response = await _api.post('/services/app/MsgNotification/UpdateFirebaseToken?fbk=$token');

  }

  static Future<int> sendNotification(BuildContext context , String title , String body , List<String> tokenList) async{
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "key=AAAAKyWo4oc:APA91bHqkfMO1M_t_thtJuwpuSKN8qadqR4Eqy5mOKFCLw3exIWjSYXHLuPZ3zuvS5pgFKfVmmlzmUSDERkN8PZVhN6iM1bVZdWRi4L5H8wHyq-G87aLD2GtNDUbAhORgtE1fXyuyzWH";
    response = await dio.post('https://fcm.googleapis.com/fcm/send',
        data: {
      "registration_ids": tokenList,
          "notification": {
          "title": title,
          "body": body
        }
    });

    return response.statusCode;
  }




}