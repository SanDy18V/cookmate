import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'Loginpage.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);
  static const routeName = "/scr/onboard";

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.2,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Cooking a ",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Delicious Food",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Easly...!",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            const SizedBox(height:10),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Discover More than 1000 food ",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("recipes in your hands and cooking ",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("it easiy!",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     height: 200,
                     width: 200,
                    decoration: const BoxDecoration(
                      image:DecorationImage(
                        image:  AssetImage("assets/img/oy1.png")
                      )
                    ),
                   ),
                 )
               ],
             ),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                    onPressed: (){
                      Get.offAllNamed(Login.routeName);}, child: Text("Get Started",style: Theme.of(context).textTheme.titleLarge)),),

          ],
        ),
      ),
    );
  }
}
