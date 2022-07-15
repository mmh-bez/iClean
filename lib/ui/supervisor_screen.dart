import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuperVisorScreen extends StatefulWidget{
  static const routeName = '/supervisor';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SuperVisorScreenState();
  }

}

class _SuperVisorScreenState extends State<SuperVisorScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('SuperVisorScreen'),
      ),
      body: Container(
        child: Text('SuperVisorScreen'),
      ),
    );
  }
}