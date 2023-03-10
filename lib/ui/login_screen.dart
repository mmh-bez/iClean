
import 'package:flutter/material.dart';
import 'package:i_clean/ui/intro_screen.dart';
import 'package:i_clean/widget/keyboard.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../utils/screen_size.dart';

class LoginScreen extends StatefulWidget{
  static const routeName = '/login';
  String type;
  LoginScreen({this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateLoginScreen();
  }

}

class _StateLoginScreen extends State<LoginScreen> {
  String text = '';
  TextEditingController _pinController = TextEditingController();
  final myController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context , listen: false).requestPermission();
    if(widget.type == 'hgc'){
      myController.text = 'HGC';
    }else{
      myController.text = 'HCO';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 32 , bottom: 12 , left: 24 , right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      IntroScreen()), (Route<dynamic> route) => false);
                },
                child: Icon( //<-- SEE HERE
                  Icons.arrow_back,
                  color: Colors.grey,
                  size: 34,
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.white.withOpacity(0.7)//<--
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12 , left: 24 , right: 24),
              child: Container(
                child: Image.asset('assets/images/iclean-logo.png' , height: ScreenSizeConfig.screenHeight /5, width: ScreenSizeConfig.screenWidth/3,),
              ),
            ),
            Container(
              width: ScreenSizeConfig.screenWidth/1.5,
              child: Column(
                children: [

                  Container(
                    height : 50 ,
                    child: TextField(
                      controller: myController,
                      enabled: false,
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
                         ),
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
                          hintStyle: TextStyle(  letterSpacing: 1),
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 10 , right: 10 , top: 4  , bottom: 4 ),
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
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            primary: Colors.red,
                            fixedSize: const Size(208, 43),
                          ),
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
