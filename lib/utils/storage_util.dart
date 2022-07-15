import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil{
  static SharedPreferences prefs;

  static Future addStringToSF(String key , String value) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future addIntToSF(String key , int value) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future addBoolToSF(String key , bool value) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }


  static Future<String> getStringValuesSF(String key) async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    return await prefs.getString(key);
  }


  static clearValues() async {
    prefs = await SharedPreferences.getInstance();
    //Remove String
    await prefs.clear();
  }
}