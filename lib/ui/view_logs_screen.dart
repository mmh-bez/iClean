
import 'package:flutter/material.dart';
import 'package:i_clean/providers/view_state.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class ViewLogsScreen extends StatefulWidget{
  static const routeName = '/viewlogs';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ViewLogsScreenState();
  }

}

class _ViewLogsScreenState extends State<ViewLogsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context , listen: false).getViewLogs(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('View Logs'),
      ),
      body: Consumer<AppProvider>(
        builder: (context , model , _){
          return model.state == ViewState.Busy ? Center(child: CircularProgressIndicator()):Container(
            child: ListView.builder(
                itemCount: model.viewLogList.length,
                itemBuilder: (context , index){
                  return Padding(
                    padding: EdgeInsets.only(left: 4 , right: 4 ,top: 2),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(model.viewLogList[index].changedDate.toString() + " => " +model.viewLogList[index].detail)),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}