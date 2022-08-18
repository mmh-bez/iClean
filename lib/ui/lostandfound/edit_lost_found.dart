
import 'package:flutter/material.dart';
import 'package:i_clean/models/lost_found/LostAndFoundDataModel.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:provider/provider.dart';

import '../../models/lost_found/lost_found_model.dart';
import '../../utils/const.dart';

class EditLostFoundScreen extends StatefulWidget{
  static const routeName = '/addlostandfound';
  LostAndFoundItem item;
  EditLostFoundScreen({this.item});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditLostFoundScreenState();
  }

}

class _EditLostFoundScreenState extends State<EditLostFoundScreen> {

  var refController = TextEditingController();
  var dateController = TextEditingController();
  var itemController = TextEditingController();
  var ownerController = TextEditingController();
  var ownerFolioController = TextEditingController();
  var ownerContactController = TextEditingController();
  var founderController = TextEditingController();
  var founderFolioController = TextEditingController();
  var founderContactController = TextEditingController();
  var descController = TextEditingController();
  var instructionController = TextEditingController();
  var infoController = TextEditingController();



  LFItemStatus _lfItemStatus;
  String selectedItemKey;
  String selectedItemStatus;

  LFArea _lfArea;
  int selectedAreaNo;
  String selectedAreaStatus;

  LFRoom _lfFounderRoom;
  String selectedFounderRoomKey;
  String selectedFounderRoomStatus;

  LFRoom _lfOwnerRoom;
  String selectedOwnerRoomKey;
  String selectedOwnerRoomStatus;


  DateTime selectedDate = DateTime.now();
  String formattedDate;

  @override
  void initState() {
    // TODO: implement initState
    //dateController.text = formatDate(selectedDate);
    formattedDate = convertDate(selectedDate);
    dateController.text = formatDate(widget.item.reportedDate);
/*    refController.text = widget.item.reference;

    itemController.text = widget.item.itemName;
    ownerController.text = widget.item.owner;
    ownerFolioController.text = widget.item.*/
    Provider.of<AppProvider>(context , listen: false).getLostFoundDataModel(context);
    Provider.of<AppProvider>(context , listen: false).getLostFoundEditData(context , widget.item.lostFoundKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit lost and found'),
      ),
      body: Consumer<AppProvider>(
        builder: (context , model ,_){
          return  model.state == ViewState.Busy ? Center(child: CircularProgressIndicator(),) :Padding(
            padding: EdgeInsets.only(top: 12 , left: 4 , right: 4),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                            width:100,
                            child: Text('Ref No')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: refController..text = model.lostFoundEditData.reference,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
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
                            width:100,
                            child: Text('Item')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: itemController..text = model.lostFoundEditData.itemName,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
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
                            width: 100,
                            child: Text('Item Status')),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              //  _showAlertDialog();
                            },
                            child: Container(
                              child: DropdownButton(
                                isExpanded: true,
                                value: _lfItemStatus,
                                hint: Text('Select'),
                                items: model.lfItemList.map((item){
                                  return DropdownMenuItem(
                                    child: Text(item.lostFoundStatus), //label of item
                                    value: item, //value of item
                                  );
                                }).toList(),
                                onChanged: ( value){
                                  setState(() {
                                    _lfItemStatus = value;
                                    selectedItemStatus = value.lostFoundStatus;
                                    selectedItemKey = value.lostFoundStatusKey;
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
                              value: _lfArea,
                              hint: Text('Select'),
                              items: model.lfAreaList.map((item){
                                return DropdownMenuItem(
                                  child: Text(item.description), //label of item
                                  value: item, //value of item
                                );
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  _lfArea = value;
                                  selectedAreaNo = _lfArea.seqno;
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
                            child: Text('Owner')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: ownerController..text = model.lostFoundEditData.owner,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
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
                            child: Text('Folio')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: ownerFolioController..text = model.lostFoundEditData.ownerFolio,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
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
                            width: 100,
                            child: Text('Room')),
                        Expanded(
                          child: Container(
                            child: DropdownButton(
                              isExpanded: true,
                              value: _lfOwnerRoom,
                              hint: Text('Select'),
                              items: model.lfRoomList.map((item){
                                return DropdownMenuItem(
                                  child: Text(item.unit), //label of item
                                  value: item, //value of item
                                );
                              }).toList(),
                              onChanged: ( value){
                                setState(() {
                                  _lfOwnerRoom = value;
                                  selectedOwnerRoomStatus = value.unit;
                                  selectedOwnerRoomKey = value.roomKey;
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
                            child: Text('Contact No')),
                        Expanded(
                          child: TextField(
                            maxLines: null,
                            controller: ownerContactController..text = model.lostFoundEditData.ownerContactNo,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
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
                            child: Text('Founder')),
                        Expanded(
                            child:TextField(
                              maxLines: null,
                              controller: founderController..text = model.lostFoundEditData.founder,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
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
                            child: Text('Folio')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: founderFolioController..text = model.lostFoundEditData.founderFolio,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                        ),
                      ],

                    ),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text('Room')),
                        Expanded(
                          child: Container(
                            child: DropdownButton(
                              isExpanded: true,
                              value: _lfFounderRoom,
                              hint: Text('Select'),
                              items: model.lfRoomList.map((item){
                                return DropdownMenuItem(
                                  child: Text(item.unit), //label of item
                                  value: item, //value of item
                                );
                              }).toList(),
                              onChanged: ( value){
                                setState(() {
                                  _lfFounderRoom = value;
                                  selectedFounderRoomStatus = value.unit;
                                  selectedFounderRoomKey = value.roomKey;
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
                            child: Text('Contact No')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: founderContactController..text = model.lostFoundEditData.founderContactNo,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
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
                            child: Text('Item Description')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: descController..text = model.lostFoundEditData.description,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
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
                            child: Text('Instruction')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: instructionController..text = model.lostFoundEditData.instruction,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
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
                            child: Text('Additional Information')),
                        Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: infoController..text = model.lostFoundEditData.additionalInfo,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                        ),
                      ],

                    ),
                    spaceUtil(),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AppProvider>(context, listen: false).createLostAndFound(context,
                            selectedItemKey, formattedDate , selectedItemStatus , selectedAreaNo , ownerController.text ,
                            ownerFolioController.text,
                            selectedOwnerRoomKey , ownerContactController.text , founderController.text ,
                            founderFolioController.text , selectedFounderRoomKey , founderContactController.text , descController.text,
                            instructionController.text, infoController.text, refController.text );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Background color
                      ),
                      child: const Text(
                        'Edit Lost & Found',
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

}