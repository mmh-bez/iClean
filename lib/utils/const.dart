import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const baseApi = "https://test.bezcloud.app/api";
String token ;
String staffKey;
String name;
bool isAdmin = false;

String formatDate(DateTime dt){
  return DateFormat('yyyy/mm/dd').format(dt);
}

String convertDate(DateTime dt){
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dt);
}

Future<void> showAlertDialog(BuildContext context , String title , String body , Function ok) async {
  return  Get.dialog(
    AlertDialog(
      title:  Text(title),
      content:  Text(body),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

Future<void> showAlertDialogTwo(BuildContext context , String title , String body , Function ok) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog( // <-- SEE HERE
        title:  Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text(body),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Ok'),
              onPressed: ok
          ),
          TextButton(
              child: const Text('Cancel'),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      );
    },
  );
}

Widget TextFieldUtil(TextEditingController controller , String label){
  return TextField(
    maxLines: null,
    controller: controller,
    decoration: InputDecoration(
        hintText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.blue),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.orangeAccent),
          borderRadius: BorderRadius.circular(15),
        )),
  );
}

Future<void> showLoaderDialog(BuildContext context)async{
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: true,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );


}

Widget spaceUtil() {
  return SizedBox(
    height: 12,
  );


}

Future<void> showTextDiaog(BuildContext context ,bool validate, String title , TextEditingController controller , Function ok)async{
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: TextField(
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
              hintText: 'Enter Voucher Number'
          ),
        ),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, child: Text('CANCEL')),
          TextButton(
              onPressed: ok, child: Text('OK')),
        ],
      );
    },
  );


}