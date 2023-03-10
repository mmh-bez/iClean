import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_clean/models/laundry/laundry_item_response.dart';
import 'package:i_clean/models/select_item_model.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:i_clean/ui/add_selected_item_screen.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

class LaundryItemScreen extends StatefulWidget{
  static const routeName = '/addlaundry';
  String roomNo;
  String voucher;
  LaundryItemScreen({this.roomNo , this.voucher});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LaundryItemScreenState();
  }

}

class _LaundryItemScreenState extends State<LaundryItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String voucherNo ;
  var voucherController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    voucherNo = widget.voucher;
    voucherController.text = voucherNo;
    Provider.of<AppProvider>(context , listen: false).getLaundryItem(context , widget.roomNo);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AppProvider>(
        builder: (context , model , _){
          return Scaffold(

              appBar: AppBar(
                centerTitle: true,
                title: Text('Laundry Item'),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 12 , top: 4),
                    child: IconButton(
                        icon: Icon(
                          Icons.add_box,
                        ),
                        onPressed: () => _showModelBottomSheet(model.laundryItemModelList.first , context),
                    ),
                  )
                ],
              ),
              body: model.state == ViewState.Busy ? Center(child: CircularProgressIndicator()): Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white54,
                      width: double.infinity,
                      height: 140,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4 , right: 4 , bottom: 2),
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8 , right: 8, top: 6 , bottom: 4),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Room# '+widget.roomNo  ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                                        Container(
                                          height: 30,

                                          child: Row(
                                            children: [
                                              Text('Voucher# '+voucherNo,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              IconButton(
                                                onPressed: (){
                                                  showDialog(barrierDismissible: false,
                                                    context:context,
                                                    builder:(BuildContext context){
                                                      return AlertDialog(
                                                        title: Text('Edit Voucher Number'),
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
                                                              }, child: Text('CANCEL')),
                                                          TextButton(
                                                              onPressed: (){
                                                                if (_formKey.currentState.validate()) {
                                                                  setState(() {
                                                                    voucherNo = voucherController.text;
                                                                  });
                                                                  Navigator.pop(context);

                                                                }
                                                              }, child: Text('OK')),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                  icon: FaIcon(FontAwesomeIcons.pencilAlt , size: 16,)),
                                            ],
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 105,
                                          child: Text('Guest'),
                                        ),
                                        Container(
                                          width: 20,
                                          child: Text(':' , style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                        Container(
                                          width: 400,
                                          child: Text(model.laundryItemModelList.first.guestName, style: TextStyle(fontSize: 16),)
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text('IN'),
                                        ),
                                        Container(
                                          width: 20,
                                          child: Image.asset('assets/images/in.png'),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 400,
                                          child: Text(formatDate(model.laundryItemModelList.first.checkInDate), style: TextStyle(fontSize: 16),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text('Out'),
                                        ),
                                        Container(
                                          width: 20,
                                          child: Image.asset('assets/images/out.png'),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 400,
                                          child: Text(formatDate(model.laundryItemModelList.first.checkOutDate) , style: TextStyle(fontSize: 16),),
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),

                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            itemCount: model.laundryItemModelList.first.addedLaundryitems.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: EdgeInsets.only(left: 4 , right: 4 ,top: 2),
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 100,
                                                child: Text(
                                                  'Date'
                                                ),
                                              ),
                                              Container(
                                                width: 20,
                                                child: Text(
                                                    ':'
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                    model.laundryItemModelList.first.addedLaundryitems[index].postDateDes
                                                ),
                                              ),
                                            ],
                                          ),

                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 100,
                                                child: Text(
                                                    'Username'
                                                ),
                                              ),
                                              Container(
                                                width: 20,
                                                child: Text(
                                                    ':'
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                    model.laundryItemModelList.first.addedLaundryitems[index].userName
                                                ),
                                              ),
                                            ],
                                          ),

                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 100,
                                                child: Text(
                                                    'Description'
                                                ),
                                              ),
                                              Container(
                                                width: 20,
                                                child: Text(
                                                    ':'
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(

                                                  child: Text(
                                                      model.laundryItemModelList.first.addedLaundryitems[index].description
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ));
        });

  }

  void _showModelBottomSheet(LaundryItemModel laundryItem , BuildContext context) async {
    Provider.of<AppProvider>(context , listen: false).updateLaundryItem(laundryItem.laundryItems  );
    showModalBottomSheet<LaundryItem>(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Consumer<AppProvider>(
          builder: (context , model , _ ){
            return FractionallySizedBox(
              heightFactor: 0.9,
              child:  Container(
                height: double.infinity,
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Laundry Items'),

                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.black,
                          ),
                          itemCount: model.tempItemSelectedList.length,
                          itemBuilder: (context , index){
                            return Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${index+1}.   '+model.tempItemSelectedList[index].description),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.indeterminate_check_box_outlined),
                                          onPressed: (){
                                            Provider.of<AppProvider>(context , listen: false).updateItemQty(model.tempItemSelectedList[index] , index , 'decrease');


                                          },
                                        ) ,
                                        Text('${context.watch<AppProvider>().tempItemSelectedList[index].qty}'),
                                        IconButton(
                                          icon: Icon(Icons.add_box_outlined),
                                          onPressed: (){
                                            // Provider.of<AppProvider>(context , listen: false).increase();
                                            Provider.of<AppProvider>(context , listen: false).updateItemQty(model.tempItemSelectedList[index] , index , 'increase');
                                          },
                                        ) ,

                                      ],
                                    ),
                                  ],
                                )



                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        TextButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),),
                            onPressed: (){
                              Provider.of<AppProvider>(context , listen: false).postSelectedItems(context ,'LaundryRoom' ,widget.roomNo , laundryItem.roomKey , laundryItem.reservationKey  , voucherController.text);
                            }, child: Text('Post Items' , style: TextStyle(color: Colors.white),)),
                        SizedBox(
                          width: 12,
                        ),
                        TextButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),),
                            onPressed: (){
                              Navigator.pop(context);

                            }, child: Text('Cancel' , style: TextStyle(color: Colors.white),))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showCountDialog(LaundryItem laundryItem , int index) {

    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return   AlertDialog(
          title: Text(laundryItem.description),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.indeterminate_check_box_outlined),
                onPressed: (){
                  Provider.of<AppProvider>(context , listen: false).decrease();

                },
              ) ,
              Text('${context.watch<AppProvider>().qty}'),
              IconButton(
                icon: Icon(Icons.add_box_outlined),
                onPressed: (){
                  Provider.of<AppProvider>(context , listen: false).increase();
                  },
              ) ,

            ],
          ),
          actions: [
            ElevatedButton(

              onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel') ,
            ),
            ElevatedButton(

                onPressed: (){

                  Navigator.pop(context);
                }, child: Text('OK') ,
            ),
          ],
        );
      },
    );

  }

  void showEditDialog(String voucher) {}


}