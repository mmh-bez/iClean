
import 'package:flutter/material.dart';
import 'package:i_clean/ui/laundry/laundry_item_screen.dart';
import 'package:provider/provider.dart';

import '../../models/room_button.dart';
import '../../providers/app_provider.dart';
import '../../providers/view_state.dart';
import '../../utils/const.dart';

class LaundryScreen extends StatefulWidget{
  static const routeName = '/laundry';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LaundryScreenState();
  }

}

class _LaundryScreenState extends State<LaundryScreen> {
  final _formKey = GlobalKey<FormState>();
  String error ='';
  int selectedIndex = 0;
  var voucherController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    Provider.of<AppProvider>(context , listen: false).getHotelFloorLaundry(context);
    Provider.of<AppProvider>(context , listen: false).getRoomLaundry(selectedIndex , context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Laundry'),
      ),
      body: Consumer<AppProvider>(
        builder: (context , model , _){
          return  model.state == ViewState.Busy ? Center(child: CircularProgressIndicator()): Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(6),
                  itemCount: model.laundryFloorList.length,
                  separatorBuilder: (context , index){
                    return SizedBox(width: 3,);
                  },
                  itemBuilder: (context , index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                          Provider.of<AppProvider>(context , listen: false).getRoomLaundry(int.parse(model.laundryFloorList[index].floor) , context);
                        });
                      },
                      child: Container(
                        width: 40,
                        color: selectedIndex == index ? Colors.blue :Colors.orange,
                        child: Center(child: Text(model.laundryFloorList[index].btnFloor , style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child:
                  Padding(
                    padding: EdgeInsets.only(left: 6 , right: 6),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 60,
                            childAspectRatio: 1,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                        itemCount: model.laundryRoomList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: (){
                              voucherController.clear();
                              model.laundryRoomList[index].roomStatus == RoomStatus.VACANT ||
                                  model.laundryRoomList[index].roomStatus == RoomStatus.HOLD
                              ? showAlertDialog(
                                  context, 'Info', "This room is vacant",  (){
                                Navigator.pop(context);
                              }) :
                              showDialog(barrierDismissible: false,
                                context:context,
                                builder:(BuildContext context){
                                  return AlertDialog(
                                    title: Text('Enter Voucher Number'),
                                    content: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        autofocus: true,
                                        controller: voucherController,
                                        validator: (text){
                                          if (text == null || text.isEmpty) {
                                            return 'Voucher can\'t be empty';
                                          }
                                          return null;
                                        },

                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            voucherController.clear();
                                          }, child: Text('CANCEL')),
                                      TextButton(
                                          onPressed: (){
                                            if (_formKey.currentState.validate()) {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LaundryItemScreen(roomNo:  model.laundryRoomList[index].room ,
                                                    voucher: voucherController.text,),
                                                ),
                                              );
                                            }
                                          }, child: Text('OK')),
                                    ],
                                  );
                                },
                              );

                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(model.laundryRoomList[index].room),
                              decoration: BoxDecoration(
                                  color: model.laundryRoomList[index].roomStatus == RoomStatus.VACANT ||
                                      model.laundryRoomList[index].roomStatus == RoomStatus.HOLD
                                  ? Colors.grey : Colors.redAccent,
                                  borderRadius: BorderRadius.circular(15)
                              ),

                            ),
                          );
                        }),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}