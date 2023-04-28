

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/authentic controllers.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final firebasecontroller = Get.find<Authentication>();
  var favlistnew;
  var favlistimgnew;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    favlistnew =firebasecontroller.favlist?.toSet().toList();
    favlistimgnew = firebasecontroller.favlistimg?.toSet().toList();
    print(firebasecontroller.favlist);
    print(favlistnew);
    print(favlistimgnew);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Favourite Rescipies",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.favorite,color: Colors.redAccent,),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                   physics: ClampingScrollPhysics(),
                   itemCount: favlistnew.length,
                  itemBuilder: (ctx,int index){
                     return Column(
                       children: [
                         SizedBox(height: 5,),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Card(
                             elevation:4,
                             child: Container(
                               height: 80,
                               child: Column(
                                 children: [
                                   SizedBox(height: 15,),
                                   ListTile(
                                     leading: CircleAvatar(
                                           radius:50,
                                       backgroundImage: NetworkImage(favlistimgnew[index]),
                                     ),
                                     title: Text(favlistnew[index],style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                                     trailing: Icon(Icons.arrow_forward,color: Colors.black,),
                                     onTap: () {
                                       // Handle tile tap
                                     },
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ],
                     );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
