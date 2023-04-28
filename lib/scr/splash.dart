import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescpies/scr/Home.dart';
import 'package:rescpies/scr/Onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_pref.dart';
import 'Nav_bar.dart';

class Mysplash extends StatefulWidget {
  const Mysplash({Key? key}) : super(key: key);
  static const routeName = "/scr/splash";
  @override
  State<Mysplash> createState() => _MysplashState();
}

class _MysplashState extends State<Mysplash> {
  Future checkuserstatus() async {
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      final userLoggedIn = await Sharedpreference().getLogedIn();
      if(userLoggedIn == false){
        // Get.offAll(LoginPage());
        Get.toNamed(Onboard.routeName);
      }else{
        // Get.offAll(MyHomePage());
       Get.toNamed(Navigation.routeName);
        Future token = Sharedpreference().getToken();
        token.then((data) async {

          //Utils.userData.data!.accessToken = data;
          if (kDebugMode) {
            print(data);
          }
        });
      }
    } else {
      await prefs.setBool('seen', true);
      // Get.offAll(()=>Onbording());
      Get.toNamed(Onboard.routeName);
    }

  }

  @override
  void initState() {
    checkuserstatus();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.white,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/myy12.png"),fit: BoxFit.contain
                  )
                ),
              ),
            ],
          ),
          const SizedBox(height: 40,),
         const Padding(
           padding: EdgeInsets.only(left: 50,right: 50),
           child: LinearProgressIndicator(),
         )
        ],
      )
    );
  }
  @override
  void dispose() {

    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
  Future<void> checkUserLoggedIn() async{
    // final _sharedPref = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 3));
    final userLoggedIn = await Sharedpreference().getLogedIn();
    if(userLoggedIn == false){
      Get.offAll(const Onboard());
    }else{
      Get.offAll(const Home());
      Future token = Sharedpreference().getToken();
      token.then((data) async {

        //Utils.userData.data!.accessToken = data;
        if (kDebugMode) {
          print(data);
        }
      });
    }
  }
}

