import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescpies/controller/Search%20Controller.dart';

import 'package:rescpies/controller/authentic%20controllers.dart';
import 'package:rescpies/scr/Home.dart';
import 'package:rescpies/scr/Loginpage.dart';
import 'package:rescpies/scr/Nav_bar.dart';
import 'package:rescpies/scr/Onboard.dart';

import 'package:rescpies/scr/signup.dart';
import 'package:rescpies/scr/splash.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
     Get.put(Authentication());
     Get.put(Searchcontroller());
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
const _brandColor = Colors.white;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blueGrey,
  );

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme = lightDynamic?.harmonized() ??
            ColorScheme.fromSeed(
              seedColor: _brandColor,
            );
        ColorScheme darkColorScheme = darkDynamic?.harmonized() ??
            ColorScheme.fromSeed(
              seedColor: _brandColor,
              brightness: Brightness.dark,
            );
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CookMate',
          home: const Mysplash(),
          builder: EasyLoading.init(),
          theme: _themeData(lightColorScheme),
          darkTheme: _themeData(darkColorScheme),
          themeMode: ThemeMode.system,
           initialRoute:Mysplash.routeName,
          routes: {
            Mysplash.routeName :(context)=> const Mysplash(),
            Onboard.routeName :(context)=>const Onboard(),
            Login.routeName:(context)=>const Login(),
            Signup.routeName:(context)=>const Signup(),
            Navigation.routeName:(context)=>Navigation(),
            PopularRecipies.routeName:(ctx)=>PopularRecipies()
          },

        );
      },
    );
  }

  ThemeData _themeData(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
    );
  }
}


