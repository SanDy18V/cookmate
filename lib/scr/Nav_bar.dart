import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rescpies/scr/Favourites.dart';

import 'package:rescpies/scr/Home.dart';
import 'package:rescpies/scr/Search.dart';
import 'package:rescpies/scr/account.dart';

import '../controller/authentic controllers.dart';



class Navigation extends StatefulWidget {

  int index;
   Navigation({Key? key,this.index=0}) : super(key: key);
  static const routeName = '/scr/bar';

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final firebasecontroller = Get.find<Authentication>();
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();


    setState(() {
      currentPageIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        backgroundColor: Colors.white70,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.restaurant_menu_rounded),
            icon: Icon(Icons.restaurant_menu_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search_rounded),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite_rounded),
            icon: Icon(Icons.favorite_outline),
            label: 'Favourites',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle_rounded),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),

        ],
      ),
      body:const [
        Home(),
        Search(),
        Favourites(),
        Account()
      ][currentPageIndex],
    );
  }
}
