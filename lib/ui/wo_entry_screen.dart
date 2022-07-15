
import 'package:flutter/material.dart';
import 'package:i_clean/models/woentry/wo_entry_model.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/utils/const.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WoEntryScreen extends StatefulWidget{
  static const routeName = '/woentry';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WoEntryScreenState();
  }

}

class _WoEntryScreenState extends State<WoEntryScreen> {
  var noteController = TextEditingController();
  var descController = TextEditingController();
  var dateController = TextEditingController();

  GetReportedBy reportedBy;
  Area area;
  Room room;
  WorkType workType;

  String selectedReportedBy;
  String staffKey;
  String selectedArea;
  String selectedRoom;
  String selectedWorkType;
  String formattedDate;
  String selectedRoomKey;
  int selectedAreaKey;
  int selectedWorkTypeKey;

  DateTime selectedDate = DateTime.now();
  String mode = "noreq";

  @override
  void initState() {
    // TODO: implement initState
    dateController.text = formatDate(selectedDate);
    formattedDate = convertDate(selectedDate);
    Provider.of<AppProvider>(context , listen: false ).getWoEntryData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        title: Text('Work Order Entry'),
      ),
      body: Consumer<AppProvider>(
        builder: (context , model , _){
          return Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    spaceUtil(),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text('Reported By*')),
                        Expanded(
                          child: Container(
                            child: DropdownButton(
                              isExpanded: true,
                              value: reportedBy,
                              hint: Text('--Select--'),
                              items: model.reportedByList.map((item){
                                return DropdownMenuItem(
                                  child: Text(item.userName), //label of item
                                  value: item, //value of item
                                );
                              }).toList(),
                              onChanged: ( value){
                                setState(() {
                                  reportedBy = value;
                                  selectedReportedBy = value.userName;
                                  staffKey = value.staffKey;
                                });
                                //change the country name//get city list.
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceUtil(),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text('Reported Date*')),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              _selectDate(context);
                            },
                            child: Container(
                              child: TextField(
                                enabled: false,
                                controller: dateController,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.date_range_outlined),
                                    labelText: 'Date',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 3, color: Colors.blue),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 3, color: Colors.orangeAccent),
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceUtil(),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text('Room#')),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                            //  _showAlertDialog();
                            },
                            child: Container(
                              child: DropdownButton(
                                isExpanded: true,
                                value: room,
                                hint: Text('--Select--'),
                                items: model.lostFoundRoomList.map((item){
                                  return DropdownMenuItem(
                                    child: Text(item.unit), //label of item
                                    value: item, //value of item
                                  );
                                }).toList(),
                                onChanged: ( value){
                                  _showAlertDialog();
                                  setState(() {
                                    room = value;
                                    selectedRoom = value.unit;
                                    selectedRoomKey = value.roomKey;
                                  });
                                  //change the country name//get city list.
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceUtil(),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text('Area#')),
                        Expanded(
                          child: Container(
                            child: DropdownButton(
                              isExpanded: true,
                              value: area,
                              hint: Text('--Select--'),
                              items: model.areaList.map((item){
                                return DropdownMenuItem(
                                  child: Text(item.description), //label of item
                                  value: item, //value of item
                                );
                              }).toList(),
                              onChanged: ( value){
                                setState(() {
                                  area = value;
                                  selectedArea = value.description;
                                  selectedAreaKey = value.seqno;
                                  print(selectedAreaKey);
                                });
                                //change the country name//get city list.
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceUtil(),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text('Work Type')),
                        Expanded(
                          child: Container(
                            child: DropdownButton(
                              isExpanded: true,
                              value: workType,
                              hint: Text('--Select--'),
                              items: model.workTypeList.map((item){
                                return DropdownMenuItem(
                                  child: Text(item.description), //label of item
                                  value: item, //value of item
                                );
                              }).toList(),
                              onChanged: ( value){
                                setState(() {
                                  workType = value;
                                  selectedWorkType = value.description;
                                  selectedWorkTypeKey = value.seqno;
                                  print(selectedWorkTypeKey);
                                });
                                //change the country name//get city list.
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceUtil(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 100,
                            child: Text('Work Description')),
                        Expanded(
                          child: TextField(
                            controller: descController,
                            decoration: InputDecoration(
                                labelText: 'Please enter work description',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 3, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 3, color: Colors.orangeAccent),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                      ],

                    ),
                    spaceUtil(),
                    Row(
                      children: [
                        Container(
                            width:100,
                            child: Text('Notes')),
                        Expanded(
                          child: TextField(
                            controller: noteController,
                            decoration: InputDecoration(
                                labelText: 'Notes',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 3, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 3, color: Colors.orangeAccent),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AppProvider>(context , listen: false).addWorkOrder(context , formattedDate , selectedArea,
                          selectedWorkType , descController.text , noteController.text ,selectedRoom , selectedRoomKey ,
                          selectedAreaKey , selectedWorkTypeKey , staffKey , mode , selectedReportedBy
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Background color
                      ),
                      child: const Text(
                        'Add Work Order',
                        style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold , color: Colors.white),
                      ),
                    )


                  ],
                ),
              ),
            ),
          );
        },
      ),


    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dateController.text = formatDate(selectedDate);
        formattedDate  = convertDate(selectedDate);
      });
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text('Confirm'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to set unit to Maintenance Required?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                mode = "noreq";
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                mode = "mainreq";
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}