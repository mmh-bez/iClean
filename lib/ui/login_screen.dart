
import 'package:flutter/material.dart';
import 'package:i_clean/widget/keyboard.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class LoginScreen extends StatefulWidget{
  static const routeName = '/login';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateLoginScreen();
  }

}

class _StateLoginScreen extends State<LoginScreen> {
  String text = '';
  TextEditingController _pinController = TextEditingController();
  final myController = TextEditingController(text: "Chancellor");

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context , listen: false).requestPermission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 32 , bottom: 12 , left: 24 , right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 12 , left: 24 , right: 24),
              child: Container(
                child: Image.asset('assets/images/icon.png' , height: 200, width: 300,),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height : 50 ,
                    child: TextField(
                      controller: myController,
                      textAlign: TextAlign.left ,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height : 50 ,
                    child: TextField(
                      controller: _pinController,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(letterSpacing: 10),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800] , letterSpacing: 1),
                          hintText: "Enter PIN Number",
                          fillColor: Colors.white24),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: NumericKeyboard(
                      mainAxisAlignment: MainAxisAlignment.center,
                      onKeyboardTap: _onKeyboardTap,
                      textColor: Colors.white,
                      rightButtonFn: () {
                        if(text.length != 0){
                          setState(() {
                            text = text.substring(0, text.length - 1);
                            _pinController.text = text;
                          });
                        }

                      },
                      rightIcon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 30,
                      ),
                      leftButtonFn: () {
                        setState(() {
                          text = '';
                          _pinController.text = text;
                        });
                      },
                      leftIcon: Text('Clear'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{

                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.login_outlined,
                          color: Colors.white,
                        ),
                        onPressed: (){
                          Provider.of<AppProvider>(context , listen:false).login(context ,myController.text, _pinController.text );
                        },
                        label: Text(
                          "Login to iClean",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          fixedSize: const Size(208, 43),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      if(text.length <= 5){
      text = text + value;
      _pinController.text = text;
      }

    });
  }
}
