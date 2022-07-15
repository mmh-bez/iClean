
import 'package:flutter/material.dart';
import 'package:i_clean/providers/app_provider.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget{
  static const routeName = '/history';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HistoryScreenState();
  }

}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  void initState() {

    Provider.of<AppProvider>(context , listen: false).getHistory(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('24hours Activities'),
      ),
      body: Consumer<AppProvider>(
        builder: (context , model , _){
          return Container(
            child: ListView.builder(
              itemCount: model.historyList.length,
                itemBuilder: (context , index){
                  return Padding(
                    padding: EdgeInsets.only(left: 4 , right: 4 ,top: 2),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(model.historyList[index].history.changedDate.toString() + " => " +model.historyList[index].history.detail)),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}