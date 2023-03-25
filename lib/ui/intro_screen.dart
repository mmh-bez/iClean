import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_clean/ui/login_screen.dart';
import 'package:i_clean/utils/const.dart';
import 'package:i_clean/utils/screen_size.dart';

class IntroScreen extends StatelessWidget{
  static const routeName = '/intro';
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().initSizeConig(context);
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(top: ScreenSizeConfig.scaledScreenHeight * 5),
              padding: EdgeInsets.only(bottom: 12 , left: 24 , right: 24),
              child: Container(
                child: Image.asset('assets/images/iclean-logo.png' , height: 400, width: 300,),
              ),
            ),
            Container(
              child: Text('Please select hotel' , style: TextStyle(fontSize: 24 ),),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    baseApi = hcoApi;
                  //  throw Exception('throw first error');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoginScreen(type: "hco")),
                    );
                  },
                  child: Card(
                    elevation: 3,
                   child: Container(
                     width: MediaQuery.of(context).size.width/2.5,
                     height: ScreenSizeConfig.screenHeight/3,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Image.asset('assets/images/hco.png' ,   height: 200, width: 300, ),
                         Text("Chancellor@Orchard" , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 24),)
                       ],
                     )
                   ),
               ),
                ),
                GestureDetector(
                  onTap: () {
                    baseApi = hgcApi;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoginScreen(type: "hgc")),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    child: Container(
                        width: MediaQuery.of(context).size.width/2.5,
                        height: ScreenSizeConfig.screenHeight/3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/images/hgc.png' ,   height: 200, width: 300, ),
                            Text("Hotel Grand Central" , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 24),)
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 56),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Ver 1.0')),
            ),
          ],
        ),
      ),
    );
  }

}