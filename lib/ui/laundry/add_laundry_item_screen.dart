import 'package:flutter/material.dart';
import 'package:i_clean/models/select_item_model.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

class AddSelectedItemScreen extends StatefulWidget{
  static const routeName = '/addItem';
  String roomNo;
  String voucherNo;
  String reservationKey;
  String roomKey;
  String type;

  AddSelectedItemScreen({this.roomNo ,this.type, this.voucherNo , this.reservationKey , this.roomKey});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddSelectedItemScreenState();
  }

}

class _AddSelectedItemScreenState extends State<AddSelectedItemScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Item'),
      ),
      body: Consumer<AppProvider>(
        builder: (context , model ,_){
          return  Padding(
            padding: EdgeInsets.only(top: 6 , left: 4 , right: 4 , bottom: 12),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                        itemCount: model.tempItemSelectedList.length,
                        itemBuilder: (context , index){
                          return GestureDetector(
                            onTap: (){
                              showEditDialog(model.tempItemSelectedList[index]);
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${index+1}.   '+model.tempItemSelectedList[index].description),
                                  Text(model.tempItemSelectedList[index].qty.toString()),
                                ],
                              ),

                            ),
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
                            Provider.of<AppProvider>(context , listen: false).postSelectedItems(context ,widget.type ,widget.roomNo , widget.roomKey , widget.reservationKey  , widget.voucherNo);
                          }, child: Text('Post Items' , style: TextStyle(color: Colors.white),)),
                      SizedBox(
                        width: 12,
                      ),
                      TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),),
                          onPressed: (){
                            showAlertDialog(context, 'Delete', 'Are you sure to delete selected laundry items.', (){
                              Provider.of<AppProvider>(context , listen: false).clearSelectedItem();
                              Navigator.pop(context);
                            });

                          }, child: Text('Clear Item' , style: TextStyle(color: Colors.white),))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),

    );
  }

  void showEditDialog(ItemSelected laundryItem) {
    Provider.of<AppProvider>(context , listen: false).addSelectedItemQty(laundryItem.qty);
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
                  Provider.of<AppProvider>(context , listen: false).decreaseSelectedItem();
                  },
              ) ,
              Text('${context.watch<AppProvider>().selectedQty}'),
              IconButton(
                icon: Icon(Icons.add_box_outlined),
                onPressed: (){
                  Provider.of<AppProvider>(context , listen: false).increaseSelectedItem();
                },
              ) ,

            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: (){
                Provider.of<AppProvider>(context , listen: false).updateSelctedItem(laundryItem);
                Navigator.pop(context);
              }, child: Text('OK') ,
            ),
          ],
        );
      },
    );

  }
}