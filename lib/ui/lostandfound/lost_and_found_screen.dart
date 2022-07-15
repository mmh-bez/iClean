import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/ui/lostandfound/add_lost_found.dart';
import 'package:i_clean/ui/lostandfound/edit_lost_found.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

class LostAndFoundScreen extends StatefulWidget{
  static const routeName = '/lostandfound';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LostAndFoundScreenState();
  }

}

class _LostAndFoundScreenState extends State<LostAndFoundScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context , listen: false).getLostFoundData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost and Found'),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AddLostFoundScreen.routeName);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.add_box_outlined , size: 34,))),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, model , _){
          return Container(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: model.lostAndFoundItemList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditLostFoundScreen(item: model.lostAndFoundItemList[index]),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 4 , right: 4 , bottom: 2),
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4 , right: 4 , top: 4 , bottom: 4),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Ref No.'+model.lostAndFoundItemList[index].reference  ,style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(formatDate(model.lostAndFoundItemList[index].reportedDate),style: TextStyle(fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12 , right: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text('Item')),
                                        Container(
                                            width: 20,
                                            child: Text(':')),
                                        Container(
                                            width: 200,
                                            child: Text(''+model.lostAndFoundItemList[index].itemName,style: TextStyle(fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12 , right: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text('Status')),
                                        Container(
                                            width: 20,
                                            child: Text(':')),
                                        Container(
                                            width: 200,
                                            child: Text(''+model.lostAndFoundItemList[index].lostFoundStatus,style: TextStyle(fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12 , right: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text('Area')),
                                        Container(
                                            width: 20,
                                            child: Text(':')),
                                        Container(
                                            width: 200,
                                            child: Text(''+model.lostAndFoundItemList[index].mArea,style: TextStyle(fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12 , right: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text('Owner')),
                                        Container(
                                            width: 20,
                                            child: Text(':')),
                                        Container(
                                            width: 200,
                                            child: Text(''+model.lostAndFoundItemList[index].owner,style: TextStyle(fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12 , right: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text('Founder')),
                                        Container(
                                            width: 20,
                                            child: Text(':')),
                                        Container(
                                            width: 200,
                                            child: Text(''+model.lostAndFoundItemList[index].founder,style: TextStyle(fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12 , right: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text('Info')),
                                        Container(
                                            width: 20,
                                            child: Text(':')),
                                        Container(
                                            width: 200,
                                            child: Text(''+model.lostAndFoundItemList[index].additionalInfo,style: TextStyle(fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ),
                      ),
                    );
                  }));
        },
      ),
      );

  }
}