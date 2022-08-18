import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_clean/models/room_button.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:i_clean/utils/const.dart';
import 'package:provider/provider.dart';

import '../../providers/view_state.dart';
import 'minibar_co_item_scren.dart';

class MiniBarCoScreen extends StatefulWidget{
  static const routeName = '/minibarco';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MiniBarCoScreenState();
  }

}

class _MiniBarCoScreenState extends State<MiniBarCoScreen> {

  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState

    Provider.of<AppProvider>(context , listen: false).getFloorMiniBarCo(context);
    Provider.of<AppProvider>(context , listen: false).getRoomMiniBarCo(selectedIndex , context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Minibar/CO'),
      ),
      body: Consumer<AppProvider>(
        builder: (context , model , _){
          return model.state == ViewState.Busy ?Center(child: CircularProgressIndicator()):Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(6),
                  itemCount: model.miniBarCoFloorList.length,
                  separatorBuilder: (context , index){
                    return SizedBox(width: 3,);
                  },
                  itemBuilder: (context , index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                          Provider.of<AppProvider>(context , listen: false).getRoomMiniBarCo(int.parse(model.miniBarCoFloorList[index].floor) , context);
                        });
                      },
                      child: Container(
                        width: 40,
                        color: selectedIndex == index ? Colors.blue :Colors.orange,
                        child: Center(child: Text(model.miniBarCoFloorList[index].btnFloor , style: TextStyle(fontWeight: FontWeight.bold),)),
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
                        itemCount: model.miniBarCoRoomList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: (){
                              model.miniBarCoRoomList[index].roomStatus == RoomStatus.OCCUPIED ?  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MinibarCoItemScreen(roomNo:  model.miniBarCoRoomList[index].room),
                                ),
                              ) :
                              showAlertDialog(
                                  context, 'Info', "This room is vacant.No action required",  (){
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                               alignment: Alignment.center,
                              child: Text(model.miniBarCoRoomList[index].room),
                              decoration: BoxDecoration(
       color: model.miniBarCoRoomList[index].roomStatus == RoomStatus.OCCUPIED
                              ? Colors.redAccent :Colors.grey,
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