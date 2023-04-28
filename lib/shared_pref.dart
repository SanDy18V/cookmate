import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreference{
   Future<bool>setuid(String uid)async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.setString("uid", uid);
   }

  Future<bool> setToken(String Access_Token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SANDY");
    return prefs.setString("token", Access_Token);
  }
  Future<bool> setLoggedIn(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("logged_in", status);
  }

  Future<bool> getLogedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("logged_in") ?? false;
  }
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SANDY VALLAVAN");
    return prefs.getString("token") ?? '';
  }
  Future<bool> setproductid(String DocumentId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.setString("documentid", DocumentId);
  }
  Future<String> getproductid( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("documentid") ?? '';
  }

  removeAll() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }

}