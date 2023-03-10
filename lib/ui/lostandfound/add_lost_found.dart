
import 'package:flutter/material.dart';
import 'package:i_clean/models/lost_found/LostAndFoundDataModel.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:provider/provider.dart';

import '../../utils/const.dart';

class AddLostFoundScreen extends StatefulWidget{
  static const routeName = '/addlostandfound';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddLostFoundScreenState();
  }

}

class _AddLostFoundScreenState extends State<AddLostFoundScreen> {

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

  String _itemError = null;
  String _areaError = '';
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
    dateController.text = formatDate(selectedDate);
    formattedDate = convertDate(selectedDate);
    Provider.of<AppProvider>(context , listen: false).getLostFoundDataModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add lost and found'),
      ),
      body: Consumer<AppProvider>(
       builder: (context , model ,_){
         return  model.state == ViewState.Busy ? Center(child: CircularProgressIndicator()) :Padding(
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
                           child: TextFieldUtil(refController, 'Ref No')
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
                             width:100,
                             child: Text('Item')),
                         Expanded(
                             child: TextField(
                               maxLines: null,
                               controller: itemController,
                               onChanged: (value){
                                 setState(() {
                                   _itemError =null;
                                 });
                               },
                               decoration: InputDecoration(
                                   hintText: "Please enter item no",
                                   errorText: _itemError,
                                   enabledBorder: OutlineInputBorder(
                                     borderSide: const BorderSide(width: 1, color: Colors.blue),
                                     borderRadius: BorderRadius.circular(15),
                                   ),
                                   focusedBorder: OutlineInputBorder(
                                     borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
                                     borderRadius: BorderRadius.circular(15),
                                   )),
                             )
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
                                 hint: Text(model.lfItemList.first.lostFoundStatus),
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
                             child: TextFieldUtil(ownerController, 'Owner')
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
                             child: TextFieldUtil(ownerFolioController, 'Owner Folio')
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
                             child: TextFieldUtil(ownerContactController, 'Owner Contact No'),
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
                             child: TextFieldUtil(founderController, 'Founder')
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
                             child: TextFieldUtil(founderFolioController, 'Founder Folio')
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
                             child: TextFieldUtil(founderContactController, 'Founder Contact No')
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
                             child: TextFieldUtil(descController, 'Item Description')
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
                             child: TextFieldUtil(instructionController, 'Instruction')
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
                             child: TextFieldUtil(infoController, 'Additional Information')
                         ),
                       ],

                     ),
                     spaceUtil(),
                     ElevatedButton(
                       onPressed: () {
                         if(itemController.text == ''){
                           setState(() {
                             _itemError = 'Required';
                           });

                         }else{
                           Provider.of<AppProvider>(context, listen: false).createLostAndFound(context,
                               selectedItemKey ?? model.lfItemList.first.lostFoundStatusKey, formattedDate , selectedItemStatus ?? model.lfItemList.first.lostFoundStatus , selectedAreaNo , ownerController.text ,
                               ownerFolioController.text,
                               selectedOwnerRoomKey , ownerContactController.text , founderController.text ,
                               founderFolioController.text , selectedFounderRoomKey , founderContactController.text , descController.text,
                               instructionController.text, infoController.text, refController.text );
                         }

                       },
                       style: ElevatedButton.styleFrom(
                         primary: Colors.blue, // Background color
                       ),
                       child: const Text(
                         'Add Lost & Found',
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