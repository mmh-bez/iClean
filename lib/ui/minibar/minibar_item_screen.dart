import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_clean/models/minibar/minibar_item_response.dart';
import 'package:i_clean/models/select_item_model.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

import '../add_selected_item_screen.dart';

class MinibarItemScreen extends StatefulWidget{
  static const routeName = '/minibaritem';
  String roomNo;
  String voucher;
  MinibarItemScreen({this.roomNo , this.voucher});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MinibarItemScreenState();
  }

}

class _MinibarItemScreenState extends State<MinibarItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String voucherNo ;
  var voucherController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context , listen: false).getMinibarItem(context , widget.roomNo);
    Provider.of<AppProvider>(context , listen: false).clearSelectedItem();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AppProvider>(
        builder: (context , model , _){
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                elevation: 4,
                child: Icon(Icons.add_box),
                onPressed: (){

                  _showModelBottomSheet(model.minibarItemList.first , context);
                },
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text('Minibar Item'),
              ),
              body: model.state == ViewState.Busy ? Center(child: CircularProgressIndicator()):
              model.state == ViewState.Error ? Center(child: Text('No Data')) :
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white54,
                      width: double.infinity,
                      height: 120,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4 , right: 4 , bottom: 2),
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8 , right: 8, top: 6 , bottom: 4),
                            child: Container(
                              child: Column(
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
                                              Text('Folio# '+model.minibarItemList.first.docNo,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                                              SizedBox(
                                                width: 4,
                                              ),
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 105,
                                          child: Text('Guest'),
                                        ),
                                        Container(
                                          width: 20,
                                          child: Text(':'),
                                        ),
                                        Container(
                                            width: 200,
                                            child: Text(model.minibarItemList.first.guestName, style: TextStyle(fontSize: 16),)
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text('IN'),
                                        ),
                                        Container(
                                          width: 20,
                                          child: Image.asset('assets/images/in.png'),
                                        ),
                                        Container(
                                          width: 200,
                                          child: Text(formatDate(model.minibarItemList.first.checkInDate), style: TextStyle(fontSize: 16),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text('Out'),
                                        ),
                                        Container(
                                          width: 20,
                                          child: Image.asset('assets/images/out.png'),
                                        ),
                                        Container(
                                          width: 200,
                                          child: Text(formatDate(model.minibarItemList.first.checkOutDate) , style: TextStyle(fontSize: 16),),
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
                            itemCount: model.minibarItemList.first.addedMinibarItems.length,
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
                                                    model.minibarItemList.first.addedMinibarItems[index].postDateDes
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
                                                    model.minibarItemList.first.addedMinibarItems[index].userName
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
                                                      model.minibarItemList.first.addedMinibarItems[index].description
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

  void _showModelBottomSheet(MinibarItemModel model , BuildContext context) async {

    showModalBottomSheet<MinibarItem>(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child:  Container(
            height: double.infinity,
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('MiniBar Items'),

                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                      itemCount: model.minibarItems.length,
                      itemBuilder: (context , index){
                        return GestureDetector(
                          onTap: (){
                            showCountDialog(model.minibarItems[index] , index+1);
                          },
                          child: Container(
                            child: Text('${index+1}.   '+model.minibarItems[index].description),
                          ),
                        );
                      }),
                ),
                TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddSelectedItemScreen(roomNo: widget.roomNo, type: 'MinibarRoom',voucherNo: voucherController.text,
                            reservationKey: model.reservationKey, roomKey: model.roomKey,
                          ),
                        ),
                      );
                    }, child: Text('View Selected Item' , style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        );
      },
    );
  }

  void showCountDialog(MinibarItem minibarItem , int index) {
    Provider.of<AppProvider>(context , listen: false).getInitialQty(ItemSelected(itemKey: minibarItem.itemKey));
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return   AlertDialog(
          title: Text(minibarItem.description),
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
                Provider.of<AppProvider>(context , listen: false).addSelectedItem( minibarItem, index);
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